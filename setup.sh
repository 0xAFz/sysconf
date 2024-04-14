#!/bin/bash

GO_VERSION="1.22.2"
OS_ARCH="linux-amd64" # change this according to your OS architecture
GO_URL="https://golang.org/dl/go$GO_VERSION.$OS_ARCH.tar.gz"
INSTALL_DIR="/usr/local"
PROFILE_FILE="$HOME/.profile"
ZSH_FILE="$HOME/.zshrc"

# main installation
apt update
apt install -y git vim tmux curl wget zsh gzip zip unzip build-essential python3-pip python3-venv python3-psutil python3-poetry

# go
if ! command -v go &> /dev/null; then
    wget -qO- "$GO_URL" | tar -C "$INSTALL_DIR" -xz

    # set up Go environment variables
    echo "export PATH=\$PATH:$INSTALL_DIR/go/bin"   | tee -a "$PROFILE_FILE" > /dev/null
    echo "export GOPATH=\$HOME/go"                  | tee -a "$PROFILE_FILE" > /dev/null
    echo "export PATH=\$PATH:\$GOPATH/bin"          | tee -a "$PROFILE_FILE" > /dev/null

    source "$PROFILE_FILE"
fi

# dnsx
if ! command -v dnsx &> /dev/null && command -v go &> /dev/null; then
    go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
fi

# nuclei
if ! command -v nuclei &> /dev/null && command -v go &> /dev/null; then
    go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
fi

# httpx
if ! command -v httpx &> /dev/null && command -v go &> /dev/null; then
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest
fi

# x8
if ! command -v x8 &> /dev/null; then
    wget -q https://github.com/Sh1Yo/x8/releases/download/v4.3.0/x86_64-linux-x8.gz -O x8.gz && gzip -d x8.gz && mv ./x8 /usr/bin && sudo chmod +x /usr/bin/x8
fi

# ffuf
if ! command -v ffuf &> /dev/null && command -v go &> /dev/null; then
    go install github.com/ffuf/ffuf/v2@latest
fi

# gospider
if ! command -v gospider &> /dev/null && command -v go &> /dev/null; then
    go install github.com/jaeles-project/gospider@latest
fi

# waybackurls
if ! command -v waybackurls &> /dev/null && command -v go &> /dev/null; then
    go install github.com/tomnomnom/waybackurls@latest
fi

# subfinder
if ! command -v subfinder &> /dev/null && command -v go &> /dev/null; then
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
fi

# shuffledns
if ! command -v shuffledns &> /dev/null && command -v go &> /dev/null; then
    go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
fi

# massdns
if [ ! -d "massdns" ]; then
    git clone https://github.com/blechschmidt/massdns.git && cd massdns && make && cd bin && cp massdns /usr/bin && cd .. && mv massdns $HOME
fi

# gau
if ! command -v gau &> /dev/null && command -v go &> /dev/null; then
    go install github.com/lc/gau/v2/cmd/gau@latest
fi

# dnsgen
if [ ! -d "dnsgen" ]; then
    python3 -m pip install --break-system-packages dnsgen
fi

# oh my zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# zsh-autosuggestions if not already installed
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

# add zsh-autosuggestions to .zshrc if not already added
if ! grep -q "zsh-autosuggestions" "$ZSH_FILE"; then
    sed -i 's/^plugins=(git)$/plugins=(git zsh-autosuggestions)/' "$ZSH_FILE"
fi

# change default shell to zsh
chsh -s /usr/bin/zsh

# set up Go environment variables
echo "export PATH=\$PATH:$INSTALL_DIR/go/bin"   | tee -a "$ZSH_FILE" > /dev/null
echo "export GOPATH=\$HOME/go"                  | tee -a "$ZSH_FILE" > /dev/null
echo "export PATH=\$PATH:\$GOPATH/bin"          | tee -a "$ZSH_FILE" > /dev/null


echo "Completed."
