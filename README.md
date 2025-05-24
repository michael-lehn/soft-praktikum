# WSL Installation und Konfiguration für die GPET-Rechner

Dieses Repository dokumentiert das Setup für die Veranstaltung
**Anwendungsorientierte Softwareentwicklung** (Soft-Praktikum) und dient
vorrangig als Merkliste für zukünftige Veranstaltungen, in denen ebenfalls WSL
zum Einsatz kommt – oder als Hilfestellung für den Fall, dass jemand die
Veranstaltung in ähnlicher Form weiterführen möchte.

Gleichzeitig kann es den Teilnehmenden helfen, ihr eigenes System entsprechend
einzurichten und unabhängig vom Laborrechner weiterzuarbeiten.

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

Repository klonen und das Setup-Skript ausführen – es übernimmt den Rest:

```bash
git clone https://github.com/michael-lehn/soft-praktikum.git
cd soft-praktikum
sh setup-wsl-env.sh
```

### 🧪 Quick & Easy (alles in einer Zeile)

Falls du es noch einfacher willst: Kopiere einfach diese Zeile ins Terminal
und drücke Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/michael-lehn/soft-praktikum/main/setup-wsl-env.sh | sh
```

> 💡 Hinweis: Diese Variante lädt **nur das Skript** herunter und führt es aus
> – es wird **nicht das ganze Git-Repository geklont**. Wenn du später den
> Quellcode oder zusätzliche Dateien brauchst, solltest du trotzdem das
> Repository klonen.

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
    vielen Graphikkarten leider nichts.

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

