#!/bin/bash

# Packages to install
pkgs=(
	"neofetch"								# CLI display info
	"bat"									# Better cat
	"tree"									# Filetree
	"neovim"								# Vim replacement
	"rofi"									# Launcher
	"awesome"								# WM
	"bitwarden-rofi-git"					# Bitwarden in rofi
	"picom-git"								# Compositor (blur, opacity)
	"flameshot"								# GUI sceenshot
	"alacritty"								# Terminal emulator
	"nitrogen"								# Sets wallpapers
	"zsh"									# Shell
	"bitwarden-cli"							# Bitwarden pw manager CLI tool
	"thunar"								# GUI file explorer
	"xdotool"								# CLI tool to simumate kb and mouse (req for bw rofi)
	"xclip"									# CLI clipboard
	"rofi-power-menu"						# Adds power menu options to rofi
	"jq"									# CLI JSON tool
	"tmux"									# Terminal multi head
	"exa"									# ls replacement
	"pa-applet-git"							# Sound control applet
	"ttf-fira-code"							# Font
	"ttf-roboto"							# Font
	"ttf-meslo-nerd-font-powerlevel10k"		# Font
	"materia-theme"							# QT theme
	"qt5-styleplugins"						# QT Plugins
	"reflector"								# Updates pkg list providers (to find the fastest)
	"network-manager-applet"				# Network applet
	"npm"									# Node package manager
	"sshfs"									# Mount filessystems
	"robo3t-bin"							# mongodb GUI
	"dropbox"								# Cloud storage
	"spotify"								# Music streamer
	"slack-desktop"							# Messaging
	"nsxiv"									# Picute viewer
	"tty-clock-git"							# Clock that runs in the terminal
	"ranger"								# CLI file explorer
	"scrot"									# CLI screenshot
	"i3lock-color"							# Lock screen
	"imagemagick"							# CLI image manipulation tool, req for lock-screen script
	"rofimoji"								# Emojipicker for rofi
	"noto-fonts-emoji"						# Req for rofimoji
	"blueman"								# Bluetooth applet
	"mpv" 									# Mediaplayer
	"xorg-xprop" 							# Display propery tool
	"pcloud-drive"							# Cloud storage
	"brave-bin"								# Brave browser
	"cbatticon"								# Systray battery icon
	"simplescreenrecorder"					# Screenrecorder
	"google-chrome-dev"						# Chrome browser (Canary)
	"galculator"							# Calculator
	"wireguard-tools"						# VPN
	"fd"									# nvim (telescope) dependency
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

createDir "${HOME}/.config"
createDir "${HOME}/.fonts"
createDir "${HOME}/zsh_extensions"

speak "-- DONE"

# 4 - Download zsh_extensions if they do no exist
space 2
speak "-- DOWNLOADING ZSH EXTENSIONS"

gitDownload "romkatv/powerlevel10k.git" "${HOME}/zsh_extensions/powerlevel10k"
gitDownload "zsh-users/zsh-autosuggestions.git" "${HOME}/zsh_extensions/zsh-autosuggestions"
gitDownload "zsh-users/zsh-syntax-highlighting.git" "${HOME}/zsh_extensions/zsh-syntax-highlighting"
gitDownload "junegunn/fzf.git" "${HOME}/zsh_extensions/fzf"

speak "-- DONE"

# 5 - Symlink directories
space 2
speak "-- LINKING DIRECTORIES"

symlinkConfigDir "awesome"
symlinkConfigDir "alacritty"
symlinkConfigDir "flameshot"
symlinkConfigDir "neofetch"
symlinkConfigDir "nvim"
symlinkConfigDir "picom"
symlinkConfigDir "rofi"
symlinkConfigDir "zsh_custom"

speak "-- DONE"

# 6 - Symlink files
space 2
speak "-- LINKING FILES"

symlinkZshCustomFile ".zshrc"
symlinkZshCustomFile ".p10k.zsh"
symlinkZshCustomFile ".fzf.zsh"

symlinkFile "${PWD}/misc/.xprofile" "${HOME}/.xprofile"

speak "-- DONE"

# 7 - Place scripts, files and dirs in correct dirs
space 2
speak "-- COPYING FILES & DIRECTORIES"

copyFileSudo "${PWD}/scripts/rofi-run" "/usr/local/bin/rofi-run" && makeExecutableSudo "/usr/local/bin/rofi-run"
copyFileSudo "${PWD}/scripts/lock-screen" "/usr/local/bin/lock-screen" && makeExecutableSudo "/usr/local/bin/lock-screen"
copyFileSudo "${PWD}/misc/pacman.conf" "/etc/pacman.conf"
copyDir "${PWD}/fonts/JetBrainsMono" "${HOME}/.fonts/"

speak "-- DONE"

# 8 - Change default shell
space 2
speak "-- CHANING SHELL"

changeShell "zsh"

speak "-- DONE"

# The end...
space 4
speak "-- Everything should be done now..."
