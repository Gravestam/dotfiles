#!/bin/bash

# Packages to install
pkgs=(
	"neofetch"
	"neovim"
	"rofi"
	"awesome"
	"bitwarden-rofi-git"
	"picom-git"
	"flameshot"
	"alacritty"
	"nitrogen"
	"zsh"
	"bitwarden-cli"
	"thunar"
	"xdotool"
	"xclip"
	"rofi-power-menu"
	"jq"
	"tmux"
	"exa"
	"pa-applet-git"
	"ttf-fira-code"
	"ttf-roboto"
	"ttf-meslo-nerd-font-powerlevel10k"
	"materia-theme"
	"qt5-styleplugins"
	"reflector"
	"network-manager-applet"
	"npm"
	"sshfs"
	"robo3t-bin"
	"dropbox"
	"spotify"
	"slack-desktop"
	"nsxiv"
	"tty-clock-git"
	"xplr"
	"scrot"
	"i3lock-color"
	"imagemagick"
	"rofimoji"
	"noto-fonts-emoji"
	"blueman"
)

function createDir {

	[ -d $1 ] || mkdir -p $1
}

function symlinkFile {

	ln -sf $1 $2
}

function symlinkConfigDir {

	local configPath="${HOME}/.config/${1}"
	local dotfileConfigPath="${PWD}/config/${1}"

	ln -sfn $dotfileConfigPath $configPath
}

function symlinkZshCustomFile {

	local zshCustomPath="${HOME}/.config/zsh_custom/${1}"
	local homePath="${HOME}/${1}"

	ln -sf $zshCustomPath $homePath
}

function gitDownload {

	[ -d $2 ] || git clone --depth 1 "https://github.com/${1}" $2
}

function changeShell {

	local shellPath=$(which $1)

	[ -f $shellPath ] && chsh -s $shellPath
}

function copyDir {

	cp -r $1 $2
}

function copyFileSudo {

	sudo cp $1 $2
}

function makeExecutableSudo {

	sudo chmod +x $1
}

function space {

	for (( c=1; c<=$1; c++ ))
	do echo ""
	done
}

function speak {

	echo $1
}

# 1 - Update DB
speak "-- UPDATING DB"

yay -Sy

speak "-- DONE"

# 2 - Install packages
space 2
speak "-- INSTALLING PACKAGES"

yay -S ${pkgs[@]}

speak "-- DONE"

# 3 - Create required directories if they do not exist
space 2
speak "-- CREATING REQUIRED DIRECTORIES"

echo "Creating: ${HOME}/.config" & createDir "${HOME}/.config"
echo "Creating: ${HOME}/.fonts" & createDir "${HOME}/.fonts"
echo "Creating: ${HOME}/zsh_extensions" & createDir "${HOME}/zsh_extensions"

speak "-- DONE"

# 4 - Download zsh_extensions if they do no exist
space 2
speak "-- DOWNLOADING ZSH EXTENSIONS"

echo "Downloading: powerlevel10k" & gitDownload "romkatv/powerlevel10k.git" "${HOME}/zsh_extensions/powerlevel10k"
echo "Downloading: zsh-autosuggestions" & gitDownload "zsh-users/zsh-autosuggestions.git" "${HOME}/zsh_extensions/zsh-autosuggestions"
echo "Downloading: zsh-syntax-highlighting" & gitDownload "zsh-users/zsh-syntax-highlighting.git" "${HOME}/zsh_extensions/zsh-syntax-highlighting"
echo "Downloading: fzf" & gitDownload "junegunn/fzf.git" "${HOME}/zsh_extensions/fzf"

speak "-- DONE"

# 5 - Symlink directories
space 2
speak "-- LINKING DIRECTORIES"

echo "Linking: awesome" & symlinkConfigDir "awesome"
echo "Linking: alacritty" & symlinkConfigDir "alacritty"
echo "Linking: flameshot" & symlinkConfigDir "flameshot"
echo "Linking: neofetch" & symlinkConfigDir "neofetch"
echo "Linking: nvim" & symlinkConfigDir "nvim"
echo "Linking: picom" & symlinkConfigDir "picom"
echo "Linking: rofi" & symlinkConfigDir "rofi"
echo "Linking: zsh_custom" & symlinkConfigDir "zsh_custom"

speak "-- DONE"

# 6 - Symlink files
space 2
speak "-- LINKING FILES"

echo "Linking: .zshrc" & symlinkZshCustomFile ".zshrc"
echo "Linking: .p10k.zsh" & symlinkZshCustomFile ".p10k.zsh"
echo "Linking: .fzf.zsh" & symlinkZshCustomFile ".fzf.zsh"

echo "Linking: .xprofile" & symlinkFile "${PWD}/misc/.xprofile" "${HOME}/.xprofile"

speak "-- DONE"

# 7 - Place scripts, files and dirs in correct dirs
space 2
speak "-- COPYING FILES & DIRECTORIES"

echo "Copying: rofi-run" & copyFileSudo "${PWD}/scripts/rofi-run" "/usr/local/bin/rofi-run" && makeExecutableSudo "/usr/local/bin/rofi-run"
echo "Copying: lock-screen" & copyFileSudo "${PWD}/scripts/lock-screen" "/usr/local/bin/lock-screen" && makeExecutableSudo "/usr/local/bin/lock-screen"
echo "Copying: pacman.conf" & copyFileSudo "${PWD}/misc/pacman.conf" "/etc/pacman.conf"
echo "Copying: JetBrainsMono" & copyDir "${PWD}/fonts/JetBrainsMono" "${HOME}/.fonts/"

speak "-- DONE"

# 8 - Change default shell
space 2
speak "-- CHANING SHELL"

changeShell "zsh"

speak "-- DONE"

# The end...
space 4
speak "-- Everything should be done now..."
