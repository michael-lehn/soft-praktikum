- Im BIOS Intel (VMX) Virtualization Technology auf enable setzten

- WSL installieren

    1. Als Student anmelden
    2. PowerShell mit Adminrechten öffnen
        - Ausführen: wsl --install
        - Neustart (falls notwendig)
    3. Als Student: Auf Ubuntu klicken
    4. In WSL: `sudo usermod -aG dialout $USER` damit man `avrdude` ohne `sudo`
       verwenden kann.

 - GitHub: `usbipd` installieren + Neustart
   (Neustart war bei mir jedenfalls notwendig)

 - In WSL: `usb_check` nach `/usr/local/bin` kopieren
