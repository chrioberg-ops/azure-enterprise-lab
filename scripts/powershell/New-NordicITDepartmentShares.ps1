[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$ShareRoot = "C:\CompanyShares"
)

Import-Module ActiveDirectory -ErrorAction Stop
Import-Module SmbShare -ErrorAction Stop

$Departments = @(
    "IT",
    "HR",
    "Finance",
    "Sales",
    "Management",
    "Consultants"
)

$Domain = Get-ADDomain
$NetBIOSName = $Domain.NetBIOSName

$AdministratorsAccount = (
    New-Object System.Security.Principal.SecurityIdentifier(
        "S-1-5-32-544"
    )
).Translate(
    [System.Security.Principal.NTAccount]
).Value

$SystemAccount = (
    New-Object System.Security.Principal.SecurityIdentifier(
        "S-1-5-18"
    )
).Translate(
    [System.Security.Principal.NTAccount]
).Value

function Ensure-Directory {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (Test-Path -LiteralPath $Path) {
        Write-Host "Directory exists: $Path" -ForegroundColor Yellow
        return
    }

    if ($PSCmdlet.ShouldProcess($Path, "Create directory")) {
        New-Item `
            -Path $Path `
            -ItemType Directory `
            -Force |
            Out-Null

        Write-Host "Created directory: $Path" -ForegroundColor Green
    }
}

function Ensure-NtfsAccessRule {
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$Identity,

        [Parameter(Mandatory)]
        [System.Security.AccessControl.FileSystemRights]$Rights
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        Write-Warning "Cannot inspect NTFS permissions because the path does not exist: $Path"
        return
    }

    $Acl = Get-Acl -LiteralPath $Path

    $ExistingRule = $Acl.Access |
        Where-Object {
            $_.IdentityReference.Value -eq $Identity -and
            $_.AccessControlType -eq "Allow" -and
            ($_.FileSystemRights -band $Rights) -eq $Rights
        }

    if ($ExistingRule) {
        Write-Host `
            "NTFS permission exists: $Identity -> $Rights on $Path" `
            -ForegroundColor Yellow

        return
    }

    if ($PSCmdlet.ShouldProcess(
        "$Identity on $Path",
        "Grant NTFS permission $Rights"
    )) {
        $Rule = New-Object `
            System.Security.AccessControl.FileSystemAccessRule(
                $Identity,
                $Rights,
                "ContainerInherit,ObjectInherit",
                "None",
                "Allow"
            )

        $Acl.AddAccessRule($Rule)

        Set-Acl `
            -LiteralPath $Path `
            -AclObject $Acl

        Write-Host `
            "Granted NTFS permission: $Identity -> $Rights on $Path" `
            -ForegroundColor Green
    }
}

function Ensure-SmbShare {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$ChangeAccessGroup
    )

    $ExistingShare = Get-SmbShare `
        -Name $Name `
        -ErrorAction SilentlyContinue

    if (-not $ExistingShare) {
        if ($PSCmdlet.ShouldProcess($Name, "Create SMB share")) {
            New-SmbShare `
                -Name $Name `
                -Path $Path `
                -FullAccess $AdministratorsAccount `
                -ChangeAccess $ChangeAccessGroup `
                -FolderEnumerationMode AccessBased `
                -CachingMode None |
                Out-Null

            Write-Host "Created SMB share: $Name" -ForegroundColor Green
        }

        return
    }

    if ($ExistingShare.Path -ne $Path) {
        Write-Warning `
            "Share $Name exists but points to $($ExistingShare.Path), expected $Path"

        return
    }

    Write-Host "SMB share exists: $Name -> $Path" -ForegroundColor Yellow

    $SharePermissions = Get-SmbShareAccess `
        -Name $Name `
        -ErrorAction Stop

    $ChangePermissionExists = $SharePermissions |
        Where-Object {
            $_.AccountName -eq $ChangeAccessGroup -and
            $_.AccessControlType -eq "Allow" -and
            $_.AccessRight -in @("Change", "Full")
        }

    if ($ChangePermissionExists) {
        Write-Host `
            "SMB permission exists: $ChangeAccessGroup -> Change on $Name" `
            -ForegroundColor Yellow
    }
    elseif ($PSCmdlet.ShouldProcess(
        "$ChangeAccessGroup on $Name",
        "Grant SMB Change permission"
    )) {
        Grant-SmbShareAccess `
            -Name $Name `
            -AccountName $ChangeAccessGroup `
            -AccessRight Change `
            -Force

        Write-Host `
            "Granted SMB permission: $ChangeAccessGroup -> Change on $Name" `
            -ForegroundColor Green
    }
}

Ensure-Directory -Path $ShareRoot

foreach ($Department in $Departments) {
    $FolderPath = Join-Path $ShareRoot $Department
    $ShareName = "${Department}$"
    $PermissionGroup = "$NetBIOSName\DL-$Department-Modify"

    $GroupExists = Get-ADGroup `
        -Identity "DL-$Department-Modify" `
        -ErrorAction SilentlyContinue

    if (-not $GroupExists) {
        Write-Warning "Required group does not exist: DL-$Department-Modify"
        continue
    }

    Ensure-Directory -Path $FolderPath

    Ensure-NtfsAccessRule `
        -Path $FolderPath `
        -Identity $SystemAccount `
        -Rights FullControl

    Ensure-NtfsAccessRule `
        -Path $FolderPath `
        -Identity $AdministratorsAccount `
        -Rights FullControl

    Ensure-NtfsAccessRule `
        -Path $FolderPath `
        -Identity $PermissionGroup `
        -Rights Modify

    Ensure-SmbShare `
        -Name $ShareName `
        -Path $FolderPath `
        -ChangeAccessGroup $PermissionGroup
}

Write-Host "`nFile server validation" -ForegroundColor Cyan

Get-SmbShare |
    Where-Object Name -in ($Departments | ForEach-Object { "${_}$" }) |
    Select-Object Name, Path, FolderEnumerationMode |
    Sort-Object Name

foreach ($Department in $Departments) {
    $ShareName = "${Department}$"

    Write-Host "`n$ShareName" -ForegroundColor Cyan

    Get-SmbShareAccess -Name $ShareName |
        Select-Object AccountName, AccessControlType, AccessRight
}
