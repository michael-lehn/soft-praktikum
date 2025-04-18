#!/bin/bash

echo "🔧 Updating package list..."
sudo apt update

echo "📦 Installing AVR toolchain and system libraries..."
sudo apt install -y \
    avrdude \
    binutils-avr \
    gcc-avr \
    avr-libc \
    make \
    python3 \
    python3-pip \
    python3-venv \
    libasound2-dev \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libsdl2-image-dev \
    portaudio19-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev

echo "🐍 Installing Python packages (user scope)..."
pip install --break-system-packages --user pyserial
pip install --break-system-packages --user keyboard
pip install --break-system-packages --user vpython
pip install --break-system-packages --user PyOpenGL PyOpenGL_accelerate
pip install --break-system-packages --user pygame
pip install --break-system-packages --user sounddevice numpy

echo "✅ Setup complete!"
echo "You may need to restart your shell or add ~/.local/bin to your PATH:"
echo '  export PATH="$HOME/.local/bin:$PATH"'

