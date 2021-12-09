## Requirements

#### Manually installed (Optional)
* [st](https://github.com/imsamuka/st)
* [paru](https://github.com/Morganamilo/paru) 
* [asdf](https://asdf-vm.com/)
* [ohmybash](https://github.com/ohmybash/oh-my-bash)

#### Pacman

```bash
# Needed
sudo pacman -S --needed base base-devel openbox tint2 jgmenu dunst feh
paru -S obmenu-generator

# Optional (with paru for AUR)
paru -S --needed \
  xorg-xset xsettingsd xrandr xkill xdotool numlockx xf86-input-wacom \ # Xorg
  exa less youtube-dl \ # Shell
  clipit volctl nm-applet \ # tint2
  lxappearance qt5ct obconf arandr ezame \ # jgmenu
  matcha-gtk-theme papirus-icon-theme capitaine-cursors \ # Theme 
  sudo mate-polkit lxqt-openssh-askpass \ # Authentication
  nemo xfce4-appfinder picom gufw flameshot gpick
```

## Repository Configuration

The setup used to store my dotfiles was taken from https://www.atlassian.com/git/tutorials/dotfiles. I changed the location to minimize dotfiles in `$HOME`. I also changed the alias from `config` to `dots` to avoid ambiguity like `config config`. If you are doing this for the first time, run:

```bash
git init --bare $HOME/.config/dotfiles
echo 'alias dots='"'"'git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'"'"'' >> $HOME/.bashrc
bash # Apply the alias
dots config --local status.showUntrackedFiles no
```

To clone this repository or any repository using this setup, run:

```bash
git clone --bare https://github.com/imsamuka/dotfiles $HOME/.config/dotfiles

# Then ignore untracked files:
cd $HOME/.config/dotfiles; git config --local status.showUntrackedFiles no; cd -

# Then run the solution below to ignore README.md files

# Then "Import" all the folders and files:
git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME checkout

# Then properly add your alias or:
echo 'source $HOME/.scripts/myshell.sh' >> $HOME/.bashrc
```


To ignore the README.md from being pulled, I implemented this solution https://stackoverflow.com/a/38408296. Essentially doing this:

```bash
cd ~/.config/dotfiles
git config core.sparsecheckout true
echo '/*' >| ./info/sparse-checkout
echo '!**/README.md' >> ./info/sparse-checkout
cd -
```

## :computer: **System Information**

- **Distribution**: Arch Linux  
- **Window Manager**: [Openbox](https://openbox.org/) ([ArchWiki](https://wiki.archlinux.org/title/openbox))
- **Shell**: Bash
- **Terminal**: [st](https://github.com/imsamuka/st) ([suckless.org](https://st.suckless.org/))
- **Display Manager**: None - [Xinit](https://wiki.archlinux.org/title/Xinit)
- **Panel**: [Tint2](https://gitlab.com/o9000/tint2) ([ArchWiki](https://wiki.archlinux.org/title/Tint2))
- **File Manager**: [Nemo](https://github.com/linuxmint/nemo) ([ArchWiki](https://wiki.archlinux.org/title/Nemo))
- **Notification Daemon**: [Dunst](https://dunst-project.org/) ([ArchWiki](https://wiki.archlinux.org/index.php/Dunst))

# Sources

- Rofi Scripts: https://github.com/adi1090x/rofi
- Openbox Configuration Ideas: https://bbs.archlinux.org/viewtopic.php?id=93126
- Personal Thanks: [owl4ce](https://github.com/owl4ce/dotfiles) and [obliviousofcraps](https://github.com/obliviousofcraps/mf-dots)
