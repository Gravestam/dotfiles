#!/bin/bash

# Packages to install
pkgs=(
	"fastfetch"								# CLI display info
	"bat"									# Better cat
	"starship"								# Prompt for zsh, bash & fish
	"procs"									# ps replacement
	"neovim"								# Vim replacement
	"ripgrep"								# Better grep
	"rofi"									# Launcher
	"awesome"								# WM
	"picom-git"								# Compositor (blur, opacity)
	"flameshot"								# GUI sceenshot
	"alacritty"								# Terminal emulator
	"nitrogen"								# Sets wallpapers
	"zsh"									# Shell
	"xdotool"								# CLI tool to simumate kb and mouse (req for bw rofi)
	"xclip"									# CLI clipboard
	"rofi-power-menu"						# Adds power menu options to rofi
	"jq"									# CLI JSON tool
	"exa"									# ls replacement
	"pasystray"								# Sound control applet
	"ttf-fira-code"							# Font
	"ttf-roboto"							# Font
	"materia-theme"							# QT theme
	"qt5-styleplugins"						# QT Plugins
	"reflector"								# Updates pkg list providers (to find the fastest)
	"network-manager-applet"				# Network applet
	"npm"									# Node package manager
	"sshfs"									# Mount filessystems
	"spotify"								# Music streamer
	"slack-desktop"							# Messaging
	"nsxiv"									# Picute viewer
	"tty-clock-git"							# Clock that runs in the terminal
	"hunter"								# CLI file explorer
	"scrot"									# CLI screenshot
	"i3lock-color"							# Lock screen
	"imagemagick"							# CLI image manipulation tool, req for lock-screen script
	"noto-fonts-emoji"						# Req for rofimoji
	"blueman"								# Bluetooth applet
	"mpv" 									# Mediaplayer
	"xorg-xprop" 							# Display propery tool
	"pcloud-drive"							# Cloud storage
	"brave-bin"								# Brave browser
	"cbatticon"								# Systray battery icon
	"simplescreenrecorder"					# Screenrecorder
	"google-chrome-dev"						# Chrome browser (Canary)
	"fd"									# nvim (telescope) dependency
	"bluez"									# bluetooth
	"bluez-tool"							# bluetooth
	"bluez-utils"							# bluetooth
	"blueberry"								# Bluetooth configuration tool
	"dunst"									# notifications
	"gnome-keyring"							# keyring
	"xterm"									# terminal
	"arandr"								# screen layout tool
	"nvidia-prime"							# nvidia gpu switching
	"expac"									# pkg info tool
	"tldr"									# Command line client for tldr, a collection of simplified and community-driven man pages.
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

paru -Sy

speak "-- DONE"

# 2 - Install packages
space 2
speak "-- INSTALLING PACKAGES"

paru -S ${pkgs[@]}

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

gitDownload "zsh-users/zsh-autosuggestions.git" "${HOME}/zsh_extensions/zsh-autosuggestions"
gitDownload "zsh-users/zsh-syntax-highlighting.git" "${HOME}/zsh_extensions/zsh-syntax-highlighting"
gitDownload "junegunn/fzf.git" "${HOME}/zsh_extensions/fzf"

speak "-- DONE"

# 5 - Symlink directories
space 2
speak "-- LINKING DIRECTORIES"

symlinkConfigDir "alacritty"
symlinkConfigDir "awesome"
symlinkConfigDir "dunst"
symlinkConfigDir "fastfetch"
symlinkConfigDir "flameshot"
symlinkConfigDir "hunter"
symlinkConfigDir "nitrogen"
symlinkConfigDir "nvim"
symlinkConfigDir "picom"
symlinkConfigDir "rofi"
symlinkConfigDir "starship"
symlinkConfigDir "zsh_custom"

speak "-- DONE"

# 6 - Symlink files
space 2
speak "-- LINKING FILES"

symlinkZshCustomFile ".zshrc"
symlinkZshCustomFile ".fzf.zsh"

symlinkFile "${PWD}/misc/.xprofile" "${HOME}/.xprofile"
symlinkFile "${PWD}/misc/.Xresources" "${HOME}/.Xresources"

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
