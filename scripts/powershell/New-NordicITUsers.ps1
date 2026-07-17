[CmdletBinding(SupportsShouldProcess)]
param(
    [SecureString]$InitialPassword
)

Import-Module ActiveDirectory -ErrorAction Stop

$Domain = Get-ADDomain
$DomainDN = $Domain.DistinguishedName
$DnsRoot = $Domain.DNSRoot
$CompanyOU = "OU=Nordic IT Solutions,$DomainDN"

$Users = @(
    @{
        GivenName   = "Anna"
        Surname     = "Andersson"
        SamAccount  = "anna.andersson"
        Department = "IT"
        Title       = "IT Administrator"
    },
    @{
        GivenName   = "Erik"
        Surname     = "Eriksson"
        SamAccount  = "erik.eriksson"
        Department = "HR"
        Title       = "HR Administrator"
    },
    @{
        GivenName   = "Sara"
        Surname     = "Svensson"
        SamAccount  = "sara.svensson"
        Department = "Finance"
        Title       = "Finance Administrator"
    },
    @{
        GivenName   = "Johan"
        Surname     = "Johansson"
        SamAccount  = "johan.johansson"
        Department = "Sales"
        Title       = "Sales Representative"
    },
    @{
        GivenName   = "Maria"
        Surname     = "Nilsson"
        SamAccount  = "maria.nilsson"
        Department = "Management"
        Title       = "Manager"
    },
    @{
        GivenName   = "David"
        Surname     = "Karlsson"
        SamAccount  = "david.karlsson"
        Department = "Consultants"
        Title       = "Consultant"
    }
)

function Get-RequiredPassword {
    if ($InitialPassword) {
        return $InitialPassword
    }

    if ($WhatIfPreference) {
        return $null
    }

    return Read-Host `
        "Enter the initial password for missing user accounts" `
        -AsSecureString
}

foreach ($UserDefinition in $Users) {
    $SamAccountName = $UserDefinition.SamAccount
    $Department = $UserDefinition.Department
    $TargetOU = "OU=$Department,$CompanyOU"
    $GroupName = "GG-$Department"
    $DisplayName = "$($UserDefinition.GivenName) $($UserDefinition.Surname)"
    $UPN = "$SamAccountName@$DnsRoot"

    $DepartmentOU = Get-ADOrganizationalUnit `
        -Identity $TargetOU `
        -ErrorAction SilentlyContinue

    if (-not $DepartmentOU) {
        Write-Warning "Required OU does not exist: $TargetOU"
        continue
    }

    $DepartmentGroup = Get-ADGroup `
        -Identity $GroupName `
        -ErrorAction SilentlyContinue

    if (-not $DepartmentGroup) {
        Write-Warning "Required group does not exist: $GroupName"
        continue
    }

    $ExistingUser = Get-ADUser `
        -Identity $SamAccountName `
        -Properties Enabled, DistinguishedName, Department, Title `
        -ErrorAction SilentlyContinue

    if (-not $ExistingUser) {
        if ($PSCmdlet.ShouldProcess(
            $DisplayName,
            "Create Active Directory user"
        )) {
            $Password = Get-RequiredPassword

            if (-not $Password) {
                throw "An initial password is required to create $SamAccountName."
            }

            New-ADUser `
                -Name $DisplayName `
                -GivenName $UserDefinition.GivenName `
                -Surname $UserDefinition.Surname `
                -DisplayName $DisplayName `
                -SamAccountName $SamAccountName `
                -UserPrincipalName $UPN `
                -Department $Department `
                -Title $UserDefinition.Title `
                -Path $TargetOU `
                -AccountPassword $Password `
                -Enabled $true `
                -ChangePasswordAtLogon $true

            Write-Host "Created user: $SamAccountName" -ForegroundColor Green
        }
    }
    else {
        Write-Host "User exists: $SamAccountName" -ForegroundColor Yellow

        if (-not $ExistingUser.Enabled) {
            if ($PSCmdlet.ShouldProcess(
                $SamAccountName,
                "Enable Active Directory user"
            )) {
                Enable-ADAccount -Identity $SamAccountName
                Write-Host "Enabled user: $SamAccountName" -ForegroundColor Green
            }
        }
        else {
            Write-Host "User enabled: $SamAccountName" -ForegroundColor Yellow
        }

        if ($ExistingUser.DistinguishedName -notlike "*$TargetOU") {
            if ($PSCmdlet.ShouldProcess(
                $SamAccountName,
                "Move user to $TargetOU"
            )) {
                Move-ADObject `
                    -Identity $ExistingUser.DistinguishedName `
                    -TargetPath $TargetOU

                Write-Host "Moved user to: $TargetOU" -ForegroundColor Green
            }
        }
        else {
            Write-Host "User OU correct: $TargetOU" -ForegroundColor Yellow
        }

        $PropertiesToUpdate = @{}

        if ($ExistingUser.Department -ne $Department) {
            $PropertiesToUpdate.Department = $Department
        }

        if ($ExistingUser.Title -ne $UserDefinition.Title) {
            $PropertiesToUpdate.Title = $UserDefinition.Title
        }

        if ($PropertiesToUpdate.Count -gt 0) {
            if ($PSCmdlet.ShouldProcess(
                $SamAccountName,
                "Update user properties"
            )) {
                Set-ADUser `
                    -Identity $SamAccountName `
                    @PropertiesToUpdate

                Write-Host "Updated properties: $SamAccountName" -ForegroundColor Green
            }
        }
        else {
            Write-Host "User properties correct: $SamAccountName" -ForegroundColor Yellow
        }
    }

    $MembershipExists = Get-ADGroupMember `
        -Identity $GroupName `
        -ErrorAction SilentlyContinue |
        Where-Object SamAccountName -eq $SamAccountName

    if ($MembershipExists) {
        Write-Host `
            "Membership exists: $SamAccountName -> $GroupName" `
            -ForegroundColor Yellow
    }
    elseif ($PSCmdlet.ShouldProcess(
        "$SamAccountName -> $GroupName",
        "Add department group membership"
    )) {
        Add-ADGroupMember `
            -Identity $GroupName `
            -Members $SamAccountName

        Write-Host `
            "Added membership: $SamAccountName -> $GroupName" `
            -ForegroundColor Green
    }
}

Write-Host "`nUser validation" -ForegroundColor Cyan

foreach ($UserDefinition in $Users) {
    Get-ADUser `
        -Identity $UserDefinition.SamAccount `
        -Properties Department, Title, Enabled, MemberOf |
        Select-Object `
            Name,
            SamAccountName,
            Enabled,
            Department,
            Title,
            DistinguishedName
}
