#!/bin/bash

packages=(
    "alacritty"
    "amd-ucode"
    "arandr"
    "asusctl"
    "awesome"
    "base"
    "base-devel"
    "bat"
    "bitwarden"
    "blueberry"
    "blueman"
    "bluez"
    "bluez-utils"
    "brave-bin"
    "brightnessctl"
    "cbatticon"
    "dunst"
    "expac"
    "eza"
    "fastfetch"
    "fd"
    "firefox"
    "flameshot"
    "git"
    "gnome-keyring"
    "grub"
    "gst-plugin-pipewire"
    "imagemagick"
    "jq"
    "less"
    "libcaca"
    "libpulse"
    "libreoffice-fresh"
    "lightdm"
    "lightdm-gtk-greeter"
    "linux"
    "linux-firmware"
    "linux-headers"
    "lxappearance"
    "materia-gtk-theme"
    "mpv"
    "neovim"
    "networkmanager"
    "network-manager-applet"
    "nitrogen"
    "noto-fonts-emoji"
    "npm"
    "nvidia-dkms"
    "nvidia-prime"
    "nvidia-settings"
    "nvidia-utils"
    "odt2txt"
    "openssh"
    "p7zip"
    "papirus-icon-theme"
    "paru"
    "paru-debug"
    "pasystray"
    "picom"
    "pipewire"
    "pipewire-alsa"
    "pipewire-jack"
    "pipewire-pulse"
    "procs"
    "qt5ct"
    "qt6ct"
    "ranger"
    "reflector"
    "ripgrep"
    "rofi"
    "rofi-power-menu"
    "rog-control-center"
    "scrot"
    "signal-desktop"
    "slack-desktop"
    "sof-firmware"
    "spotify"
    "sshfs"
    "starship"
    "studio-3t"
    "supergfxctl"
    "sxiv"
    "thunar"
    "thunar-archive-plugin"
    "thunar-volman"
    "tldr"
    "ttf-cascadia-code-nerd"
    "ttf-fira-code"
    "ttf-firacode-nerd"
    "ttf-jetbrains-mono-nerd"
    "ttf-meslo-nerd"
    "ttf-nerd-fonts-symbols"
    "ttf-roboto"
    "udiskie"
    "udisks2"
    "ueberzug"
    "unzip"
    "visual-studio-code-bin"
    "wireplumber"
    "xarchiver"
    "xclip"
    "xdg-user-dirs"
    "xdg-user-dirs-gtk"
    "xdotool"
    "xf86-video-amdgpu"
    "xorg-server"
    "zsh"
)

install_packages() {

    echo "-- INSTALLING PACKAGES"

    for pkg in "${packages[@]}"; do
        yay -S --needed "$pkg"
    done

    echo "-- DONE"
}

# Function to start services
start_services() {
    echo "-- STARTING SERVICES"
    for pkg in "${packages[@]}"; do
        case $pkg in
            lightdm)
                sudo systemctl enable lightdm.service
                sudo systemctl start lightdm.service
                ;;
            networkmanager)
                sudo systemctl enable NetworkManager.service
                sudo systemctl start NetworkManager.service
                ;;
            supergfxd)
                sudo systemctl enable supergfxd.service
                sudo systemctl start supergfxd.service
                ;;
            bluetooth)
                sudo systemctl enable bluetooth.service
                sudo systemctl start bluetooth.service
                ;;
            *) ;;
        esac
    done
    echo "-- DONE"
}

# Function to create required directories
create_directories() {
    echo "-- CREATING REQUIRED DIRECTORIES"
    mkdir -p "${HOME}/.config" "${HOME}/.fonts" "${HOME}/zsh_custom"
    echo "-- DONE"
}

# Function to download zsh extensions
download_zsh_extensions() {
    echo "-- DOWNLOADING ZSH EXTENSIONS"
    git clone --depth 1 "https://github.com/zsh-users/zsh-autosuggestions.git" "${HOME}/zsh_custom/zsh-autosuggestions"
    git clone --depth 1 "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${HOME}/zsh_custom/zsh-syntax-highlighting"
    git clone --depth 1 "https://github.com/junegunn/fzf.git" "${HOME}/zsh_custom/fzf"
    echo "-- DONE"
}

# Function to symlink directories
symlink_directories() {
    echo "-- SYMLINKING DIRECTORIES"
    ln -sfn "${PWD}/config/alacritty" "${HOME}/.config/alacritty"
    ln -sfn "${PWD}/config/awesome" "${HOME}/.config/awesome"
    ln -sfn "${PWD}/config/dunst" "${HOME}/.config/dunst"
    ln -sfn "${PWD}/config/fastfetch" "${HOME}/.config/fastfetch"
    ln -sfn "${PWD}/config/flameshot" "${HOME}/.config/flameshot"
    ln -sfn "${PWD}/config/ranger" "${HOME}/.config/ranger"
    ln -sfn "${PWD}/config/nitrogen" "${HOME}/.config/nitrogen"
    ln -sfn "${PWD}/config/picom" "${HOME}/.config/picom"
    ln -sfn "${PWD}/config/rofi" "${HOME}/.config/rofi"
    ln -sfn "${PWD}/config/starship" "${HOME}/.config/starship"
    ln -sfn "${PWD}/config/zsh_custom" "${HOME}/.config/zsh_custom"
    echo "-- DONE"
}

# Function to symlink files
symlink_files() {
    echo "-- SYMLINKING FILES"
    ln -sf "${PWD}/config/zsh_custom/.zshrc" "${HOME}/.zshrc"
    ln -sf "${PWD}/config/zsh_custom/.fzf.zsh" "${HOME}/.fzf.zsh"
    ln -sf "${PWD}/misc/.xprofile" "${HOME}/.xprofile"
    ln -sf "${PWD}/misc/.Xresources" "${HOME}/.Xresources"
    echo "-- DONE"
}

# Function to copy files and directories
copy_files() {
    echo "-- COPYING FILES & DIRECTORIES"
    sudo cp "${PWD}/scripts/rofi-run" "/usr/local/bin/rofi-run" && sudo chmod +x "/usr/local/bin/rofi-run"
    sudo cp "${PWD}/scripts/cliphistory " "/usr/local/bin/cliphistory" && sudo chmod +x "/usr/local/bin/cliphistory"
    sudo cp "${PWD}/scripts/lock-screen" "/usr/local/bin/lock-screen" && sudo chmod +x "/usr/local/bin/lock-screen"
    sudo cp "${PWD}/misc/pacman.conf" "/etc/pacman.conf"
    echo "-- DONE"
}

# Function to change default shell
change_shell() {
    echo "-- CHANGING SHELL"
    chsh -s "$(which zsh)"
    echo "-- DONE"
}

# Function to display information about the script and packages
show_info() {
    echo "This script automates the setup of Arch and AwesomeWM on a ROG Zephyrus DUO"
	echo "... And btw, i fucking hate Nvidia..."

    echo "The following packages will be installed:"
    printf "%s\n" "${packages[@]}"
}

# Main menu
main_menu() {
    echo "Welcome to the setup script!"
    echo "Please select an action:"
    echo "1. Install packages"
    echo "2. Create directories"
    echo "3. Download Zsh extensions"
    echo "4. Symlink directories"
    echo "5. Symlink files"
    echo "6. Copy files"
    echo "7. Change default shell"
    echo "8. Start services"
    echo "9. Show information"
    echo "10. Exit"

    read -p "Enter your choice: " choice
    case $choice in
        1) install_packages ;;
        2) create_directories ;;
        3) download_zsh_extensions ;;
        4) symlink_directories ;;
        5) symlink_files ;;
        6) copy_files ;;
        7) change_shell ;;
        8) start_services ;;
        9) show_info ;;
        10) exit ;;
        *) echo "Invalid choice. Please enter a valid option." ;;
    esac
}

# Main function
main() {
    while true; do
        main_menu
    done
}

# Execute main function
main
