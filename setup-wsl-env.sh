#!/bin/bash

echo "🔧 Adding $USER to group dialout (so you can use avrdude w/o sudo)"
sudo usermod -aG dialout $USER

echo "🔧 Updating package list..."
sudo apt update

echo "📦 Installing AVR toolchain, python and some libraries..."
sudo apt install -y \
    avrdude \
    binutils-avr \
    gcc-avr \
    avr-libc \
    make \
    screen \
    python3 \
    python3-pip \
    python3-venv \
    python-is-python3 \
    libasound2-dev \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libsdl2-image-dev \
    portaudio19-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev


echo "📦 Installing usb_check ..."
sudo cp usb_check /usr/local/bin
sudo chmod a+x /usr/local/bin/usb_check

echo "📦 Installing arduino command line interface ..."
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
sudo mv bin/arduino-cli /usr/local/bin

echo "🐍 Installing Python packages (user scope)..."
pip install --break-system-packages --user pyserial
pip install --break-system-packages --user keyboard
pip install --break-system-packages --user vpython
pip install --break-system-packages --user PyOpenGL PyOpenGL_accelerate
pip install --break-system-packages --user pygame
pip install --break-system-packages --user sounddevice numpy

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "🔧 Adding ~/.local/bin to PATH in ~/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    export PATH="$HOME/.local/bin:$PATH"
fi

if ! powershell.exe -Command "Get-Command usbipd -ErrorAction SilentlyContinue" >/dev/null; then
    echo "⚠️  Installing usbipd-win (requires admin rights on the Windows host)..."
    powershell.exe -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install usbipd'"
    echo "ℹ️  A Windows UAC prompt should have appeared."
    echo "   If nothing happened, please open a PowerShell **as administrator** and run:"
    echo "     winget install usbipd"
else
    echo "✅ usbipd already installed."
fi

if ! powershell.exe -Command "Get-Command python -ErrorAction SilentlyContinue" >/dev/null; then
    echo "⚠️   Installing Python on the Windows host (requires admin rights)..."
    powershell.exe -Command "Start-Process powershell -Verb runAs -ArgumentList 'winget install --id Python.Python.3 --source winget'"
    echo "ℹ️   A Windows UAC prompt should have appeared."
    echo "   If nothing happened, please open a PowerShell **as administrator** and run:"
    echo "     winget install --id Python.Python.3"
else
    echo "✅ Python is already installed on the Windows host."
fi

PYWIN="/mnt/c/Users/$(cmd.exe /c "echo %USERNAME%" | tr -d '\r')/AppData/Local/Microsoft/WindowsApps/python.exe"
if [ ! -x "$PYWIN" ]; then
    echo "⚠️  Warning: python.exe not found in expected location ($PYWIN)."
    echo "    It may take effect after restarting WSL or logging off and on again."
fi

echo "📦 Installing python-win (wrapper for python on Windows host) ..."
sudo cp python-win /usr/local/bin
sudo chmod a+x /usr/local/bin/python-win


#hack: because python 3.12 is buggy
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.13

if ! echo "$PATH" | grep -q "alias python="; then
    echo "🔧 add 'alias python=python3.13  in ~/.bashrc"
    echo 'alias python=python3.13' >> "$HOME/.bashrc"
    export PATH="$HOME/.local/bin:$PATH"
    alias python=python3.13
fi


echo "✅ Setup complete!"
