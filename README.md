
# dotfiles

#### Disclaimer

Please review `setup.sh` prior to executing it. By default it ***WILL DELETE*** files and directories that are currently present on the system and is linked in this script

#### Dependencies

You need to run Arch and have `yay` installed (If a different AUR helper is installed, the `setup.sh` needs to be modified)

#### 1.

```
git clone git@github.com:Gravestam/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

#### 2.

Add to `/etc/environment`
```
XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2
```
