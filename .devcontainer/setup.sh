#!/bin/bash
set -euo pipefail

echo "Setting up Fallout 1 Switch dev environment..."

# generic
apt-get update -qq
apt-get install -y -qq --no-install-recommends \
  git build-essential cmake ninja-build pkg-config ccache gdb zip unzip wget ca-certificates

echo "DEVKITPRO=${DEVKITPRO:-}"
echo "DEVKITA64=${DEVKITA64:-}"
echo "PATH=$PATH"

require_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "Missing: $1"; exit 1; }; }

require_cmd aarch64-none-elf-gcc
aarch64-none-elf-gcc --version | head -1
require_cmd cmake
require_cmd elf2nro
require_cmd nacptool

# Build dir
mkdir -p build

git config --global --add safe.directory /workspace || true

