# Writes "Failed songs.txt" for a playlist folder, based on Sockseek's _index.csv.
param([string]$Dir)
$ErrorActionPreference = 'Stop'
try {
    if (-not (Test-Path -LiteralPath $Dir)) { exit 0 }
    $reasons = @{
        '1' = 'bad search'; '2' = 'ran out of retries'; '4' = 'downloads failed (try again later)';
        '5' = 'other error'; '7' = 'cancelled'; '9' = 'not on Soulseek'; '10' = 'no matching version'
    }
    $failed = @()
    foreach ($idx in Get-ChildItem -LiteralPath $Dir -Filter '_index.csv' -Recurse -File) {
        foreach ($r in @(Import-Csv -LiteralPath $idx.FullName -Encoding UTF8)) {
            # state: 0 pending, 1 done, 2 failed, 3 already had it, 4 not found last time
            if ($r.state -in @('0', '2', '4')) {
                $why = $reasons[[string]$r.failurereason]
                if (-not $why) { $why = if ($r.state -eq '0') { 'did not finish' } else { 'failed' } }
                $artist = ($r.artist -split ';') -join ', '
                $failed += "$artist - $($r.title)   [$why]"
            }
        }
    }
    $out = Join-Path $Dir 'Failed songs.txt'
    if ($failed.Count -eq 0) {
        if (Test-Path -LiteralPath $out) { Set-Content -LiteralPath $out -Value 'Nothing failed - everything downloaded.' -Encoding UTF8 }
        Write-Host 'Nothing failed.'
    } else {
        $failed | Sort-Object -Unique | Set-Content -LiteralPath $out -Encoding UTF8
        Write-Host "$($failed.Count) song(s) failed - list saved to: $out"
    }
    exit 0
} catch {
    Write-Host "Couldn't make the failed list: $($_.Exception.Message)"
    exit 0
}
