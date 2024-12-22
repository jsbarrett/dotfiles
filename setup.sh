#!/bin/bash

# -------------------------------------
# use dark mode
# -------------------------------------

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# -------------------------------------
# set background
# -------------------------------------

if ls ~/Pictures | grep -q "kanagawa.jpg"; then
  :
else
  cd $HOME/Pictures
  # TODO: determine more permanent/reliable source for background image
  wget https://github.com/basecamp/omakub/raw/refs/heads/master/themes/kanagawa/background.jpg
  mv background.jpg kanagawa.jpg
  cd -
fi

gsettings set org.gnome.desktop.background picture-uri $HOME/Pictures/kanagawa.jpg
gsettings set org.gnome.desktop.background picture-uri-dark $HOME/Pictures/kanagawa.jpg

# -------------------------------------
# hide home folder on desktop
# -------------------------------------

gsettings set org.gnome.shell.extensions.ding show-home false

# -------------------------------------
# VLC
# -------------------------------------

if ! command -v -- "vlc" > /dev/null 2>&1; then
  sudo apt install vlc -y
fi


# -------------------------------------
# install fonts
# -------------------------------------

if [ ! -d ~/.local/share/fonts ]; then
  mkdir -p ~/.local/share/fonts
fi

if ls ~/.local/share/fonts | grep -q "CaskaydiaMonoNerdFont"; then
  :
else
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
  unzip CascadiaMono.zip -d CascadiaFont
  cp CascadiaFont/*.ttf ~/.local/share/fonts
  rm -rf CascadiaMono.zip CascadiaFont
  cd -
fi

if ls ~/.local/share/fonts | grep -q "JetBrainsMono"; then
  :
else
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d JetBrainsMono
  cp JetBrainsMono/*.ttf ~/.local/share/fonts
  rm -rf JetBrainsMono.zip JetBrainsMono
  cd -
fi

# -------------------------------------
# install tmux (and config)
# TODO: setup config
# -------------------------------------

if ! command -v -- "tmux" > /dev/null 2>&1; then
  sudo apt install tmux -y
fi

# tmux yank dependency
if ! command -v -- "xsel" > /dev/null 2>&1; then
  sudo apt install xsel -y
fi

# -------------------------------------
# install ripgrep
# -------------------------------------

if ! command -v -- "rg" > /dev/null 2>&1; then
  sudo apt install ripgrep -y
fi

# -------------------------------------
# install alacritty
# TODO: setup config
# -------------------------------------

if ! command -v -- "alacritty" > /dev/null 2>&1; then
  sudo apt install -y alacritty
  mkdir -p ~/.config/alacritty
  sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
fi

# -------------------------------------
# build tools
# -------------------------------------

if ! command -v -- "gcc" > /dev/null 2>&1; then
  sudo apt install -y build-essential
fi

# -------------------------------------
# install fzf
# -------------------------------------

if ! command -v -- "fzf" > /dev/null 2>&1; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# -------------------------------------
# install nvim (and config)
# -------------------------------------

if ! command -v -- "nvim" > /dev/null 2>&1; then
  cd /tmp
  wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
  tar -xf nvim.tar.gz
  sudo install nvim-linux64/bin/nvim /usr/local/bin/nvim
  sudo cp -R nvim-linux64/lib /usr/local/
  sudo cp -R nvim-linux64/share /usr/local/
  rm -rf nvim-linux64 nvim.tar.gz
  cd -
fi

# -------------------------------------
# install vs code
# -------------------------------------

if ! command -v -- "code" > /dev/null 2>&1; then
  cd /tmp
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
  rm -f packages.microsoft.gpg
  cd -

  sudo apt update -y
  sudo apt install -y code
fi

# -------------------------------------
# remove app dock
# -------------------------------------

if gnome-extensions info ubuntu-dock@ubuntu.com | grep -q "Enabled: Yes"; then
  gnome-extensions disable ubuntu-dock@ubuntu.com
fi

# -------------------------------------
# decrease key repeat lag
# -------------------------------------

gsettings set org.gnome.desktop.peripherals.keyboard delay 200
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15

# -------------------------------------
# remove adaptive screen brightness
# -------------------------------------

gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

# -------------------------------------
# stop screen dimming in powersaver mode
# -------------------------------------

gsettings set org.gnome.settings-daemon.plugins.power idle-brightness 100

# -------------------------------------
# use traditional trackpad scrolling
# -------------------------------------

gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

# -------------------------------------
# show battery percentage
# -------------------------------------

gsettings set org.gnome.desktop.interface show-battery-percentage true

# -------------------------------------
# turn off alert sounds
# -------------------------------------

gsettings set org.gnome.desktop.sound event-sounds false

# -------------------------------------
# turn off system sounds
# -------------------------------------

# TODO (disable sound when changing volume)
# currently done through gui via settings>sound>sounds>volume levels>system sounds

# -------------------------------------
# install btop
# -------------------------------------

if ! command -v -- "btop" > /dev/null 2>&1; then
  pushd /tmp

  wget https://github.com/aristocratos/btop/releases/download/v1.4.0/btop-x86_64-linux-musl.tbz
  tar -xvjf btop-x86_64-linux-musl.tbz

  pushd btop
  sudo make install

  popd
  rm -rf btop
  rm btop-x86_64-linux-musl.tbz

  popd
fi

# -------------------------------------
# install ollama
# -------------------------------------

# if ! command -v -- "ollama" > /dev/null 2>&1; then
#   curl -fsSL https://ollama.com/install.sh | sh
# fi
# https://github.com/ollama/ollama/blob/main/docs/linux.md#uninstall

# -------------------------------------
# show time in AM/PM
# -------------------------------------

gsettings set org.gnome.desktop.interface clock-format '12h'   

# -------------------------------------
# install zsh
# -------------------------------------

if ! command -v -- "zsh" > /dev/null 2>&1; then
  sudo apt install zsh -y
fi

# -------------------------------------
# install/setup starship for bash/zsh
# TODO: config file
# -------------------------------------
if ! command -v -- "starship" > /dev/null 2>&1; then
  cd /tmp
  curl -sS https://starship.rs/install.sh | sh
  cd -
  echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
  echo 'eval "$(starship init zsh)"' >> $HOME/.zshrc
fi

# -------------------------------------
# install docker
# -------------------------------------

if ! command -v -- "docker" > /dev/null 2>&1; then
  cd /tmp

  # Add the official Docker repo
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  
  # Install Docker engine and standard plugins
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
  
  # Give this user privileged Docker access
  sudo usermod -aG docker ${USER}
  newgrp docker

  # Limit log size to avoid running out of disk
  echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

  cd -
fi

# -------------------------------------
# install nodejs
# -------------------------------------

if ! command -v -- "node" > /dev/null 2>&1; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm install node
fi

# -------------------------------------
# install pnpm
# -------------------------------------

if ! command -v -- "pnpm" > /dev/null 2>&1; then
  curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# -------------------------------------
# install nodemon
# -------------------------------------

if ! command -v -- "nodemon" > /dev/null 2>&1; then
  pnpm i -g nodemon
fi

# -------------------------------------
# install autocannon
# -------------------------------------

if ! command -v -- "autocannon" > /dev/null 2>&1; then
  pnpm i -g autocannon
fi

# -------------------------------------
# install live-server
# -------------------------------------

if ! command -v -- "live-server" > /dev/null 2>&1; then
  npm install -g live-server
fi

# -------------------------------------
# install beekeeper
# -------------------------------------

# if ! command -v -- "beekeeper-studio" > /dev/null 2>&1; then
if dpkg -l | grep -q "beekeeper-studio"; then
  :
else
  cd /tmp

  curl -fsSL https://deb.beekeeperstudio.io/beekeeper.key | sudo gpg --dearmor --output /usr/share/keyrings/beekeeper.gpg \
    && sudo chmod go+r /usr/share/keyrings/beekeeper.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/beekeeper.gpg] https://deb.beekeeperstudio.io stable main" \
    | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list > /dev/null

  sudo apt update && sudo apt install beekeeper-studio -y

  cd -
fi

# -------------------------------------
# install brave
# -------------------------------------

if ! command -v -- "brave-browser" > /dev/null 2>&1; then
  sudo apt install curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update -y
  sudo apt install brave-browser -y
fi

# -------------------------------------
# install aws cli
# -------------------------------------

if ! command -v -- "aws" > /dev/null 2>&1; then
  cd /tmp
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  cd -
fi

# -------------------------------------
# install aws ssm plugin
# -------------------------------------

if ! command -v -- "session-manager-plugin" > /dev/null 2>&1; then
  cd /tmp

  curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
  sudo dpkg -i session-manager-plugin.deb

  cd -
fi

# -------------------------------------
# install signal
# -------------------------------------

if ! command -v -- "signal-desktop" > /dev/null 2>&1; then
  cd /tmp

  # 1. Install official public software signing key:
  wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
  cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

  # 2. Add repository to list of repositories:
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
    sudo tee /etc/apt/sources.list.d/signal-xenial.list

  # 3. Update package database and install Signal:
  sudo apt update && sudo apt install signal-desktop

  cd -
fi
if ! grep -q "alias kamal" $HOME/.bashrc; then
  # echo "alias kamal='echo \"hi\"'" >> $HOME/.bashrc
  echo "alias kamal='docker run -it --rm -v \"\${PWD}:/workdir\" -v \"\${SSH_AUTH_SOCK}:/ssh-agent\" -v /var/run/docker.sock:/var/run/docker.sock -e \"SSH_AUTH_SOCK=/ssh-agent\" ghcr.io/basecamp/kamal:latest'" >> $HOME/.bashrc
fi

# -------------------------------------
# setup shell and shortcuts
# -------------------------------------

if ! sudo dpkg --get-selections | grep fuse > /dev/null 2>&1; then
  sudo add-apt-repository universe
  sudo apt install libfuse2t64
fi


# -------------------------------------
# setup shell and shortcuts
# -------------------------------------

# TODO
# - backup of code/ssh keys/Documents

# bashrc
if ! grep -q "alias x=exit" $HOME/.bashrc; then
  echo "alias x=exit" >> $HOME/.bashrc
fi
if ! grep -q "alias v=nvim" $HOME/.bashrc; then
  echo "alias v=nvim" >> $HOME/.bashrc
fi
if ! grep -q "alias roadmap" $HOME/.bashrc; then
  echo 'alias roadmap="nvim /home/jacob/Documents/notes/roadmap.txt"' >> $HOME/.bashrc
fi
if ! grep -q 'export PATH="$PATH:$HOME/.scripts"' $HOME/.bashrc; then
  echo 'export PATH="$PATH:$HOME/.scripts"' >> $HOME/.bashrc
fi
if ! grep -q 'MORE SENSIBLE BASH' $HOME/.bashrc; then
  echo '' >> $HOME/.bashrc
  echo '# MORE SENSIBLE BASH' >> $HOME/.bashrc
  echo 'if [ -t 1 ]' >> $HOME/.bashrc
  echo 'then' >> $HOME/.bashrc
  echo '  bind "set completion-ignore-case on"' >> $HOME/.bashrc
  echo '  bind "set completion-map-case on"' >> $HOME/.bashrc
  echo '  bind "set show-all-if-ambiguous on"' >> $HOME/.bashrc
  echo '  bind "TAB:menu-complete"' >> $HOME/.bashrc
  echo 'fi' >> $HOME/.bashrc
  echo '' >> $HOME/.bashrc
  echo "# Append to the history file, don't overwrite it" >> $HOME/.bashrc
  echo 'shopt -s histappend' >> $HOME/.bashrc
  echo '' >> $HOME/.bashrc
  echo '# Save multi-line commands as one command' >> $HOME/.bashrc
  echo 'shopt -s cmdhist' >> $HOME/.bashrc
  echo '' >> $HOME/.bashrc
  echo "# Huge history. Doesn't appear to slow things down, so why not?" >> $HOME/.bashrc
  echo 'HISTSIZE=100000' >> $HOME/.bashrc
  echo 'HISTFILESIZE=100000' >> $HOME/.bashrc
  echo '' >> $HOME/.bashrc
  echo '# Avoid duplicate entries' >> $HOME/.bashrc
  echo 'HISTCONTROL="erasedups:ignoreboth"' >> $HOME/.bashrc
  echo '' >> $HOME/.bashrc
  echo "# Don't record some commands" >> $HOME/.bashrc
  echo 'export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:x:clear"' >> $HOME/.bashrc
  echo '' >> $HOME/.bashrc
  echo '# Useful timestamp format' >> $HOME/.bashrc
  echo 'HISTTIMEFORMAT="%F %T "' >> $HOME/.bashrc
  echo '' >> $HOME/.bashrc
  echo 'shopt -s autocd' >> $HOME/.bashrc
  echo 'shopt -s dirspell' >> $HOME/.bashrc
  echo 'shopt -s cdspell' >> $HOME/.bashrc
fi

# zshrc
if ! grep -q "alias v=nvim" $HOME/.zshrc; then
  echo "alias v=nvim" >> $HOME/.zshrc
fi
if ! grep -q "alias x=exit" $HOME/.zshrc; then
  echo "alias x=exit" >> $HOME/.zshrc
fi
if ! grep -q 'export PATH="$PATH:$HOME/.scripts"' $HOME/.zshrc; then
  echo 'export PATH="$PATH:$HOME/.scripts"' >> $HOME/.zshrc
fi

# -------------------------------------
# remap caps lock to ctrl
# -------------------------------------

if ! grep -q "ctrl:nocaps" /etc/default/keyboard; then
  sudo sed -i 's/XKBOPTIONS=""/XKBOPTIONS="ctrl:nocaps"/' /etc/default/keyboard
  sudo dpkg-reconfigure keyboard-configuration
  echo "You will want to log out and back in for changes to take effect"
fi

