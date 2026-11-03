# 🧹 Pulisci Cache NVIDIA

**Libera RAM e GB di disco mettendo da parte la cache degli shader NVIDIA.** Gratis, open source, by **Santa Cruz RP**.

🎮 [Server FiveM Santa Cruz RP](https://santacruzroleplay.online) · 💬 [Discord](https://discord.gg/santacruzroleplay) · 📺 [Twitch](https://twitch.tv/ispanico75)

---

## A cosa serve

Il driver NVIDIA salva gli shader dei giochi nella cartella `DXCache`. Col tempo può arrivare a **decine di GB**, e i file più grossi (`.nvph`) vengono tenuti in memoria e occupano RAM. Puoi controllarlo con [RAMMap di Microsoft](https://learn.microsoft.com/sysinternals/downloads/rammap), nella scheda **File Summary**.

Questo programmino **sposta la cache in una cartella a parte** e NVIDIA ne ricrea una nuova e pulita.

- ✅ **Non cancella niente**: i file finiscono in `DXCache_vecchia_<data>`, accanto all'originale
- ✅ **Funziona anche con i programmi aperti**: i file in uso vengono saltati
- ✅ **Controlla le due cartelle** della cache (`AppData\Local` e `AppData\LocalLow`)
- ✅ **Codice leggibile**: sono due file di testo, aprili col Blocco note e guarda cosa fanno

Serve solo su **Windows con scheda video NVIDIA**.

## Come si usa

1. **Scarica** il progetto: pulsante verde **Code → Download ZIP**, poi estrai lo zip.
2. **Metti un limite alla cache**, se no ricresce: *Pannello di controllo NVIDIA → Gestisci impostazioni 3D → Impostazioni globali → Dimensione cache shader → **10 GB** → Applica*.
3. **Chiudi i giochi** e fai doppio clic su **`pulisci_cache_nvidia.bat`**.
4. Se Windows mostra *"PC protetto da Windows"*, clicca **Ulteriori informazioni → Esegui comunque**. Esce perché il file non è firmato, ma lo puoi leggere tutto prima di lanciarlo.

Vuoi solo vedere quanto è grande la tua cache, senza spostare niente? Apri PowerShell nella cartella e lancia:

```powershell
powershell -ExecutionPolicy Bypass -File .\pulisci_cache_nvidia.ps1 -Prova
```

## Dopo

- Le prime volte che apri un gioco potresti avere **qualche scatto**: la cache si sta ricostruendo, è normale.
- Se dopo qualche giorno va tutto bene, **cancella le cartelle `DXCache_vecchia_...`** in `%LOCALAPPDATA%\NVIDIA` e `%USERPROFILE%\AppData\LocalLow\NVIDIA`.
- Se qualcosa va storto: cancella la `DXCache` nuova e rinomina `DXCache_vecchia_...` in `DXCache`.

Conviene farlo solo se la cache è grande, sopra i 10 GB circa.

## ☕ Offrimi un caffè

Il programma è e resta gratis. Se ti è stato utile e vuoi offrirmi un caffè da 1 €, il link arriva presto qui. Nel frattempo passa a salutarci su [Twitch](https://twitch.tv/ispanico75)!

---

### 🇬🇧 English

Moves the NVIDIA shader cache (`DXCache`) to a backup folder so the driver rebuilds a fresh one, freeing disk space and RAM. Nothing gets deleted, files in use are skipped. Set *NVIDIA Control Panel → Shader Cache Size* to 10 GB first, then run `pulisci_cache_nvidia.bat`. NVIDIA GPUs on Windows only.

---

Licenza [MIT](LICENSE) · Fatto con ❤️ da **Santa Cruz RP**
