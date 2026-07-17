[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$DomainDN = "DC=corp,DC=nordicit,DC=local",
    [string]$CompanyName = "Nordic IT Solutions",
    [switch]$CreateTestUsers
)

Import-Module ActiveDirectory -ErrorAction Stop

$CompanyOU = "OU=$CompanyName,$DomainDN"

$Departments = @(
    "IT",
    "HR",
    "Finance",
    "Sales",
    "Management",
    "Consultants"
)

function Ensure-OrganizationalUnit {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path
    )

    $DistinguishedName = "OU=$Name,$Path"

    $ExistingOU = Get-ADOrganizationalUnit `
        -Identity $DistinguishedName `
        -ErrorAction SilentlyContinue

    if ($ExistingOU) {
        Write-Host "OU exists: $DistinguishedName" -ForegroundColor Yellow
        return
    }

    if ($PSCmdlet.ShouldProcess($DistinguishedName, "Create organizational unit")) {
        New-ADOrganizationalUnit `
            -Name $Name `
            -Path $Path `
            -ProtectedFromAccidentalDeletion $true

        Write-Host "Created OU: $DistinguishedName" -ForegroundColor Green
    }
}

function Ensure-ADSecurityGroup {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [ValidateSet("Global", "DomainLocal")]
        [string]$Scope,

        [string]$Description
    )

    $ExistingGroup = Get-ADGroup `
        -Filter "SamAccountName -eq '$Name'" `
        -ErrorAction SilentlyContinue

    if ($ExistingGroup) {
        Write-Host "Group exists: $Name" -ForegroundColor Yellow
        return $ExistingGroup
    }

    if ($PSCmdlet.ShouldProcess($Name, "Create security group")) {
        New-ADGroup `
            -Name $Name `
            -SamAccountName $Name `
            -GroupCategory Security `
            -GroupScope $Scope `
            -Path $Path `
            -Description $Description

        Write-Host "Created group: $Name" -ForegroundColor Green
    }

    return Get-ADGroup `
        -Filter "SamAccountName -eq '$Name'" `
        -ErrorAction SilentlyContinue
}

Ensure-OrganizationalUnit `
    -Name $CompanyName `
    -Path $DomainDN

foreach ($Department in $Departments) {
    Ensure-OrganizationalUnit `
        -Name $Department `
        -Path $CompanyOU
}

foreach ($TechnicalOU in @("Users", "Computers", "Servers")) {
    Ensure-OrganizationalUnit `
        -Name $TechnicalOU `
        -Path $CompanyOU
}

$PermissionGroupOU = "OU=Users,$CompanyOU"

foreach ($Department in $Departments) {
    $DepartmentOU = "OU=$Department,$CompanyOU"
    $GlobalGroup = "GG-$Department"
    $DomainLocalGroup = "DL-$Department-Modify"

    Ensure-ADSecurityGroup `
        -Name $GlobalGroup `
        -Path $DepartmentOU `
        -Scope Global `
        -Description "Department security group for $Department" | Out-Null

    Ensure-ADSecurityGroup `
        -Name $DomainLocalGroup `
        -Path $PermissionGroupOU `
        -Scope DomainLocal `
        -Description "Modify access to the $Department file share" | Out-Null

    $MembershipExists = Get-ADGroupMember `
        -Identity $DomainLocalGroup `
        -ErrorAction SilentlyContinue |
        Where-Object SamAccountName -eq $GlobalGroup

    if (-not $MembershipExists) {
        if ($PSCmdlet.ShouldProcess(
            "$GlobalGroup -> $DomainLocalGroup",
            "Add AGDLP group membership"
        )) {
            Add-ADGroupMember `
                -Identity $DomainLocalGroup `
                -Members $GlobalGroup

            Write-Host `
                "Added $GlobalGroup to $DomainLocalGroup" `
                -ForegroundColor Green
        }
    }
    else {
        Write-Host `
            "Membership exists: $GlobalGroup -> $DomainLocalGroup" `
            -ForegroundColor Yellow
    }
}

if ($CreateTestUsers) {
    $DefaultPassword = Read-Host `
        "Enter temporary password for test users" `
        -AsSecureString

    $Users = @(
        @{
            GivenName = "Anna"
            Surname = "Andersson"
            SamAccountName = "anna.andersson"
            Department = "IT"
        },
        @{
            GivenName = "Erik"
            Surname = "Eriksson"
            SamAccountName = "erik.eriksson"
            Department = "HR"
        },
        @{
            GivenName = "Sara"
            Surname = "Svensson"
            SamAccountName = "sara.svensson"
            Department = "Finance"
        },
        @{
            GivenName = "Johan"
            Surname = "Johansson"
            SamAccountName = "johan.johansson"
            Department = "Sales"
        },
        @{
            GivenName = "Maria"
            Surname = "Nilsson"
            SamAccountName = "maria.nilsson"
            Department = "Management"
        },
        @{
            GivenName = "David"
            Surname = "Karlsson"
            SamAccountName = "david.karlsson"
            Department = "Consultants"
        }
    )

    foreach ($User in $Users) {
        $ExistingUser = Get-ADUser `
            -Filter "SamAccountName -eq '$($User.SamAccountName)'" `
            -ErrorAction SilentlyContinue

        if (-not $ExistingUser) {
            $DisplayName = "$($User.GivenName) $($User.Surname)"
            $UserOU = "OU=$($User.Department),$CompanyOU"

            if ($PSCmdlet.ShouldProcess(
                $User.SamAccountName,
                "Create Active Directory user"
            )) {
                New-ADUser `
                    -Name $DisplayName `
                    -GivenName $User.GivenName `
                    -Surname $User.Surname `
                    -DisplayName $DisplayName `
                    -SamAccountName $User.SamAccountName `
                    -UserPrincipalName "$($User.SamAccountName)@corp.nordicit.local" `
                    -Department $User.Department `
                    -Path $UserOU `
                    -AccountPassword $DefaultPassword `
                    -Enabled $true `
                    -ChangePasswordAtLogon $true

                Write-Host `
                    "Created user: $($User.SamAccountName)" `
                    -ForegroundColor Green
            }
        }
        else {
            Write-Host `
                "User exists: $($User.SamAccountName)" `
                -ForegroundColor Yellow
        }

        $GroupName = "GG-$($User.Department)"

        $UserIsMember = Get-ADGroupMember `
            -Identity $GroupName `
            -Recursive `
            -ErrorAction SilentlyContinue |
            Where-Object SamAccountName -eq $User.SamAccountName

        if (-not $UserIsMember) {
            if ($PSCmdlet.ShouldProcess(
                "$($User.SamAccountName) -> $GroupName",
                "Add user to department group"
            )) {
                Add-ADGroupMember `
                    -Identity $GroupName `
                    -Members $User.SamAccountName
            }
        }
    }
}

Write-Host "`nActive Directory structure validation" -ForegroundColor Cyan

Get-ADOrganizationalUnit `
    -SearchBase $CompanyOU `
    -Filter * |
    Select-Object Name, DistinguishedName |
    Sort-Object Name

Get-ADGroup `
    -SearchBase $CompanyOU `
    -Filter 'Name -like "GG-*" -or Name -like "DL-*-Modify"' |
    Select-Object Name, GroupScope, GroupCategory |
    Sort-Object Name
