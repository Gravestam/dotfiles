
# Archinsall guide on Asus Zephyrous DUO (Nvidia)
This system is a dualscreen laptop with an AMD Ryzen CPU and with integrated AMD graphics. It also runs an nvidia RTX 3080 as descrete graphics.

#### Preinstall

Make sure you have an internet connection, for wifi use following.

```
iwctl
```

```
station wlan0 show
station wlan0 scan
station wlan0 connect <SSID>
```

exit out of iwctl

To populate the gdp keys run

```
pacman-key --init
pacman-key --populate archlinux
```

Update pacman config (this is not needed)

Uncomment `Color` & `VerbosePkgLists`
Uncomment & change value to `ParallelDownloads` (higher value means more simultanous downloads)
Add `ILoveCandy` (cause pacman...)

Config would look something like this
```
# Misc options
#UseSysLog
Color
#NoProgressBar
CheckSpace
VerbosePkgLists
ParallelDownloads = 8
ILoveCandy
```

#### Archinstall

Use the `archinstall` official script
Go through and set all options as you see fit.

I use `grub` as bootloader and have encrypted drives
I use the `minimal` profile, the setupscript will handle the packages neede for this build when arch is installed

In additional packages i enter the following
```
git linux-headers neovim xdg-user-dirs xdg-user-dirs-gtk xf86-video-amdgpu nvidia-dkms nvidia-settings nvida-utils
```

I use `NetworkManager` as network config
Check `multilib` in optional repos

#### Post Install (select yes to chroot)

Edit `/etc/mkinitcpio.conf`
In `MODULES` add `amdgpu nvidia nvidia_modeset nvidia_uvm nvidia_drm`

Run `mkinitcpio -P`

Edit `/etc/default/grub`
In `GRUB_CMDLINE_LINUX` add `nvidia_drm.modeset=1 rd.driver.blacklist=nouveau modprob.blackslist=nouveau`

Run `grub-mkconfig -o /boot/grub/grub.cfg`

Reboot the system, clone this repo and run the setup script