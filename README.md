# WSL Installation und Konfiguration für die GPET-Rechner

Dieses Repository dient als Merkliste und Setup-Anleitung zur Installation und
Konfiguration von WSL für die Veranstaltung **Anwendungsorientierte
Softwareentwicklung** (Soft-Praktikum). Es soll dir (Michael) die Vorbereitung
in kommenden Jahren erleichtern – und gleichzeitig den Studierenden helfen, ihr
eigenes System entsprechend aufzusetzen.

---

## 1. WSL installieren

Die WSL-Installation ist inzwischen eigentlich einfach:

```powershell
wsl --install
```

Dazu eine **PowerShell mit Administratorrechten** öffnen.

### ❗ Stolperstein: BIOS-Einstellungen

Was leider **viele Stunden Lebenszeit** gekostet hat:  
Nach der Installation ließ sich WSL bei manchen Rechnern nicht starten. Die
Fehlermeldung war unbrauchbar.

**Ursache:** Virtualisierung im BIOS war deaktiviert.

**Lösung:**

1. Rechner neu starten und ins BIOS/UEFI gehen.
2. Die Option `Intel (VMX) Virtualization Technology` auf **Enabled** setzen.
3. Änderungen speichern, neu starten.

Wenn man das weiß, ist es leicht. Wenn nicht … reden wir lieber nicht darüber.

---

## 2. WSL konfigurieren

Skript `setup-wsl-env.sh` ausführen – es übernimmt den Rest:

```bash
./setup-wsl-env.sh
```

### Das macht das Skript:

- 📦 **Installiert alle benötigten Pakete** (AVR-Toolchain, Python, SDL2, usw.)
- 🔌 **Installiert `usb_check`**, ein Hilfsskript, das automatisch alle
  **USB-Ports mit CP210x-Geräten** an WSL durchreicht.
  > Hat das Leben verändert. Näheres erspare ich euch.
- 🐍 **Installiert `python-win`**, ein Shellskript, das es erlaubt, **Python
  unter Windows** aus WSL heraus aufzurufen.
  - Falls nötig, wird **Python auf dem Windows-Host automatisch
    nachinstalliert** (über `winget`).
  - Grund: unter Windows funktioniert OpenGL besser – Linuxtreiber taugen bei
    vielen Laptops leider nichts.

---

## 3. Spezielle Kommandos

| Befehl        | Funktion                                                  |
|---------------|-----------------------------------------------------------|
| `usb_check`   | Leitet Mikrocontroller-USB-Geräte (CP210x) korrekt        |
|               | an WSL durch.                                             |
| `python`      | Führt Python unter **WSL/Linux** aus – gut für            |
|               | **USB-Zugriff**, aber schwache OpenGL-Performance.        |
| `python-win`  | Führt Python unter **Windows** aus – sehr gute            |
|               | **OpenGL**-Performance, aber der USB-Zugriff ist meiner   |
|               | Meinung nach unnötig kompliziert. (Schon die richtige     |
|               | Portnummer zu finden, ist eine Zumutung.)                 |

> ❗ Ein praktikabler Workaround für USB-Zugriff aus `python-win` steht noch
> aus.

---

## 4. Ziel des Ganzen

Damit lassen sich alle Projekte aus dem Praktikum auch **auf dem eigenen
Rechner** bearbeiten – mit funktionierendem USB-Zugriff oder funktionierendem
OpenGL, je nach Bedarf.

---

## 💡 Hinweise

- Falls `usbipd` nicht installiert ist, wird es beim Setup automatisch
  nachinstalliert (mit Admin-Rechten).
- Nach dem Setup ggf. Terminal neu starten oder `~/.bashrc` neu laden, damit
  `$HOME/.local/bin` im Pfad ist.

