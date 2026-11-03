# Pulisci Cache NVIDIA - by Santa Cruz RP
# Mette da parte la cache degli shader NVIDIA (DXCache): NVIDIA ne ricrea una nuova e pulita.
# Non cancella niente: sposta i file in una cartella "DXCache_vecchia_<data>" accanto all'originale.
# I file in uso (programmi aperti) vengono saltati, quindi si puo' lanciare in qualsiasi momento.
#
# Uso:  pulisci_cache_nvidia.bat            (normale)
#       pulisci_cache_nvidia.ps1 -Prova     (mostra cosa farebbe, senza spostare niente)

param([switch]$Prova)

function Scrivi-Banner {
    Write-Host ''
    Write-Host '  ============================================' -ForegroundColor Cyan
    Write-Host '     PULISCI CACHE NVIDIA  -  by Santa Cruz RP' -ForegroundColor Cyan
    Write-Host '  ============================================' -ForegroundColor Cyan
    Write-Host ''
}

function Scrivi-Link {
    Write-Host ''
    Write-Host '  Ti è stato utile? Passa a trovarci:' -ForegroundColor Yellow
    Write-Host '    Server FiveM : https://santacruzroleplay.online'
    Write-Host '    Discord      : https://discord.gg/santacruzroleplay'
    Write-Host '    Twitch       : https://twitch.tv/ispanico75'
    Write-Host ''
}

function GB($byte) { '{0:N2} GB' -f ($byte / 1GB) }

Scrivi-Banner
if ($Prova) { Write-Host '  MODALITÀ PROVA: non verrà spostato niente.' -ForegroundColor Magenta; Write-Host '' }

$stamp = Get-Date -Format 'yyyyMMdd_HHmm'
$cartelle = @(
    (Join-Path $env:LOCALAPPDATA 'NVIDIA\DXCache'),
    (Join-Path $env:USERPROFILE 'AppData\LocalLow\NVIDIA\DXCache')
)

$trovata = $false
$totSpostati = 0; $totByte = 0; $totBloccati = 0

foreach ($src in $cartelle) {
    if (-not (Test-Path -LiteralPath $src)) { continue }
    $trovata = $true
    $file = @(Get-ChildItem -LiteralPath $src -File -Force -ErrorAction SilentlyContinue)
    $dim = ($file | Measure-Object Length -Sum).Sum
    Write-Host "  Cartella: $src"
    Write-Host "  Contiene: $($file.Count) file, $(GB $dim)"

    if ($file.Count -eq 0 -or $Prova) { Write-Host ''; continue }

    $dst = Join-Path (Split-Path $src) "DXCache_vecchia_$stamp"
    New-Item -ItemType Directory -Force -Path $dst | Out-Null
    $spostati = 0; $byte = 0; $bloccati = 0
    foreach ($f in $file) {
        try {
            Move-Item -LiteralPath $f.FullName -Destination $dst -ErrorAction Stop
            $spostati++; $byte += $f.Length
        } catch { $bloccati++ }
    }
    if ($spostati -eq 0) { Remove-Item -LiteralPath $dst -Force }

    Write-Host "  Spostati: $spostati file, $(GB $byte)" -ForegroundColor Green
    if ($bloccati -gt 0) { Write-Host "  Saltati perché in uso: $bloccati file (normale)" -ForegroundColor DarkGray }
    Write-Host ''
    $totSpostati += $spostati; $totByte += $byte; $totBloccati += $bloccati
}

if (-not $trovata) {
    Write-Host '  Nessuna cache NVIDIA trovata su questo PC.' -ForegroundColor Yellow
    Write-Host '  Forse la scheda video è AMD o Intel: in quel caso questo programma non serve.'
} elseif (-not $Prova) {
    Write-Host "  FATTO: messi da parte $(GB $totByte) di cache." -ForegroundColor Green
    Write-Host ''
    Write-Host '  Le prime volte che apri un gioco potresti avere qualche scatto: la cache si sta rifacendo.'
    Write-Host '  Se dopo qualche giorno va tutto bene, cancella le cartelle "DXCache_vecchia_..." per liberare spazio.'
    Write-Host '  Consiglio: Pannello di controllo NVIDIA > Gestisci impostazioni 3D >'
    Write-Host '  "Dimensione cache shader" = 10 GB, così non ricresce all''infinito.'
}

Scrivi-Link
