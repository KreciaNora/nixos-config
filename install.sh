#!/usr/bin/env bash
set -e

echo "=== NixOS Installation Script ==="
echo ""

# Sprawdź czy jesteś w /mnt
if [ "$PWD" != "/mnt/nixos-config" ]; then
    echo "BŁĄD: Musisz uruchomić ten skrypt z /mnt/nixos-config"
    echo "Najpierw:"
    echo "  cd /mnt"
    echo "  git clone https://github.com/krecikowa/nixos-config"
    echo "  cd nixos-config"
    echo "  bash install.sh"
    exit 1
fi

# Sprawdź czy /mnt jest zamontowany
if ! mountpoint -q /mnt; then
    echo "BŁĄD: /mnt nie jest zamontowany!"
    echo "Najpierw zamontuj partycje."
    exit 1
fi

echo "=== Krok 1: Generowanie hardware-configuration.nix ==="
nixos-generate-config --root /mnt --show-hardware-config > hardware-configuration.nix
echo "✓ Wygenerowano hardware-configuration.nix"
echo ""

# Wykryj czy ma NVIDIA
if lspci | grep -i nvidia > /dev/null; then
    HAS_NVIDIA=true
    echo "🎮 Wykryto kartę NVIDIA"
else
    HAS_NVIDIA=false
    echo "💻 Brak karty NVIDIA (Intel/AMD)"
fi
echo ""

echo "=== Krok 2: Konfiguracja modułów ==="

# Backup oryginalnego configuration.nix
cp configuration.nix configuration.nix.backup

if [ "$HAS_NVIDIA" = false ]; then
    echo "Wyłączam moduł nvidia.nix..."
    sed -i 's|./modules/nvidia.nix|# ./modules/nvidia.nix|g' configuration.nix
    echo "✓ NVIDIA wyłączona"
else
    echo "✓ NVIDIA pozostaje włączona"
fi
echo ""

echo "=== Krok 3: Hostname ==="
echo "Obecny hostname w konfiguracji:"
grep 'hostName' configuration.nix
echo ""
read -p "Zmienić hostname? (t/N): " change_hostname

if [[ "$change_hostname" =~ ^[Tt]$ ]]; then
    read -p "Podaj nowy hostname: " new_hostname
    sed -i "s/networking.hostName = \".*\";/networking.hostName = \"$new_hostname\";/" configuration.nix
    echo "✓ Zmieniono hostname na: $new_hostname"
else
    echo "✓ Hostname pozostaje bez zmian"
fi
echo ""

echo "=== Krok 4: Instalacja NixOS ==="
echo "UWAGA: To zajmie kilka-kilkanaście minut"
echo ""
read -p "Rozpocząć instalację? (t/N): " confirm

if [[ ! "$confirm" =~ ^[Tt]$ ]]; then
    echo "Instalacja anulowana."
    mv configuration.nix.backup configuration.nix
    exit 0
fi

echo ""
echo "Instaluję..."
nixos-install --flake .#nixos

echo ""
echo "=== Instalacja zakończona! ==="
echo ""
echo "Następne kroki:"
echo "1. Ustaw hasło dla użytkownika krecikowa:"
echo "   nixos-enter --root /mnt"
echo "   passwd krecikowa"
echo "   exit"
echo ""
echo "2. Restart:"
echo "   reboot"
echo ""
echo "3. Po pierwszym uruchomieniu:"
echo "   sudo cp -r /mnt/nixos-config ~/nixos-config"
echo "   sudo chown -R krecikowa:users ~/nixos-config"
echo "   sudo rm -rf /etc/nixos"
echo "   sudo ln -s ~/nixos-config /etc/nixos"
echo "   sudo nixos-rebuild switch --flake ~/nixos-config#nixos"
echo ""
echo "NIE commituj hardware-configuration.nix do gita!"
