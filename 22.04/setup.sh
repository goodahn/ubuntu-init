setup_color() {
  # Only use colors if connected to a terminal
  if ! is_tty; then
    FMT_RAINBOW=""
    FMT_RED=""
    FMT_GREEN=""
    FMT_YELLOW=""
    FMT_BLUE=""
    FMT_BOLD=""
    FMT_RESET=""
    return
  fi

  if supports_truecolor; then
    FMT_RAINBOW="
      $(printf '\033[38;2;255;0;0m')
      $(printf '\033[38;2;255;97;0m')
      $(printf '\033[38;2;247;255;0m')
      $(printf '\033[38;2;0;255;30m')
      $(printf '\033[38;2;77;0;255m')
      $(printf '\033[38;2;168;0;255m')
      $(printf '\033[38;2;245;0;172m')
    "
  else
    FMT_RAINBOW="
      $(printf '\033[38;5;196m')
      $(printf '\033[38;5;202m')
      $(printf '\033[38;5;226m')
      $(printf '\033[38;5;082m')
      $(printf '\033[38;5;021m')
      $(printf '\033[38;5;093m')
      $(printf '\033[38;5;163m')
    "
  fi

  FMT_RED=$(printf '\033[31m')
  FMT_GREEN=$(printf '\033[32m')
  FMT_YELLOW=$(printf '\033[33m')
  FMT_BLUE=$(printf '\033[34m')
  FMT_BOLD=$(printf '\033[1m')
  FMT_RESET=$(printf '\033[0m')
}

# 1. git, 2. vim, 3. tmux, 4. zsh 설치
sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4AB0F789CBA31744CC7DA76A8CF63AD3F06FC659
sudo apt update -y
sudo apt install -y git vim tmux zsh

# 4. oh-my-zsh 설치
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
sudo chsh -s $(which zsh) $USER

# 5. docker 설치
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 5. docker-desktop 설치
wget "https://desktop.docker.com/linux/main/amd64/docker-desktop-4.15.0-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64" -O docker-desktop-amd64.deb
sudo apt install -y ./docker-desktop-amd64.deb
rm docker-desktop-amd64.deb

# 6. pyenv 설치
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# 7. goenv 설치
git clone https://github.com/syndbg/goenv.git ~/.goenv
echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc
echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(goenv init -)"' >> ~/.zshrc
echo 'export PATH="$GOROOT/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.zshrc

# 8. nvm 설치
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# 9. 소프트웨어 설치 확인
setup_color

# 9.1 git 설치 확인
if git --version > /dev/null; then
    printf '%s git installation succeed \n' $FMT_GREEN
else
    printf '%s git installation failed \n' $FMT_RED
fi

# 9.2 vim 설치 확인
if vim --version > /dev/null; then
    printf '%s vim installation succeed \n' $FMT_GREEN
else
    printf '%s vim installation failed \n' $FMT_RED
fi

# 9.3 tmux 설치 확인
if tmux -V > /dev/null; then
    printf '%s tmux installation succeed \n' $FMT_GREEN
else
    printf '%s tmux installation failed \n' $FMT_RED
fi

# 9.4 zsh 설치 확인
if which zsh > /dev/null; then
    printf '%s vim installation succeed \n' $FMT_GREEN
else
    printf '%s vim installation failed \n' $FMT_RED
fi

# 9.5 docker 설치 확인
if docker --version > /dev/null; then
    printf '%s docker installation succeed \n' $FMT_GREEN
else
    printf '%s docker installation failed \n' $FMT_RED
fi

# 9.6 pyenv 설치 확인
if pyenv --version > /dev/null; then
    printf '%s pyenv installation succeed \n' $FMT_GREEN
else
    printf '%s pyenv installation failed \n' $FMT_RED
fi

# 9.7 goenv 설치 확인
if goenv --version > /dev/null; then
    printf '%s goenv installation succeed \n' $FMT_GREEN
else
    printf '%s goenv installation failed \n' $FMT_RED
fi

# 9.8 nvm 설치 확인
if nvm --version > /dev/null; then
    printf '%s nvm installation succeed \n' $FMT_GREEN
else
    printf '%s nvm installation failed \n' $FMT_RED
fi