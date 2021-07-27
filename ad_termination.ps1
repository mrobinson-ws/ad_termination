$OU = Get-ADOrganizationalUnit -Properties CanonicalName -Filter * | Sort-Object CanonicalName |
ForEach-Object{
    [pscustomobject]@{
        Name          = Split-Path $_.CanonicalName -Leaf
        CanonicalName = $_.CanonicalName
        UserCount     = @(Get-AdUser -Filter * -SearchBase $_.DistinguishedName -SearchScope OneLevel).Count
        ComputerCount = @(Get-AdComputer -Filter * -SearchBase $_.DistinguishedName -SearchScope OneLevel).Count
        DistinguishedName = $_.DistinguishedName
    }
} | Out-Gridview -OutputMode Single