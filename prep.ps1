# Copies an Exportify playlist CSV and adds a "Length" column (in seconds),
# so Sockseek can reject live versions, remixes, and extended cuts.
param([string]$In, [string]$Out)
$ErrorActionPreference = 'Stop'
try {
    $rows = @(Import-Csv -LiteralPath $In -Encoding UTF8)
    if ($rows.Count -eq 0) { exit 1 }
    $durCol = $rows[0].PSObject.Properties.Name | Where-Object { $_ -like 'Duration*' } | Select-Object -First 1
    foreach ($r in $rows) {
        $sec = ''
        if ($durCol -and $r.$durCol) {
            $ms = 0.0
            if ([double]::TryParse($r.$durCol, [ref]$ms)) { $sec = [string][math]::Round($ms / 1000) }
        }
        $r | Add-Member -NotePropertyName 'Length' -NotePropertyValue $sec -Force
    }
    $rows | Export-Csv -LiteralPath $Out -NoTypeInformation -Encoding UTF8
    exit 0
} catch {
    Write-Host $_.Exception.Message
    exit 1
}
