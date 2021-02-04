#!/usr/bin/env bash

git pull origin master;

function bootstrap() {
  # Install prompt
  echo "Installing starship..."
  if ! [ "$(command -v starship)" ]; then
    curl -fsSL https://starship.rs/install.sh | bash;
  fi

  # Install environments
  echo "Installing nvm..."
  if ! [ "$(command -v nvm)" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash;
    nvm use;
  fi
  echo "Installing rustup..."
  if ! [ "$(command -v rustup)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;
  fi

  # Install other tools
  echo "Installing gh cli..."
  if ! [ "$(command -v gh)" ]; then
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0;
    sudo apt-add-repository https://cli.github.com/packages;
    sudo apt update;
    sudo apt install gh;
  fi
  echo "Installing zoxide..."
  if ! [ "$(command -v z)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sh
  fi
  echo "Installing misc packages..."
    sudo apt install neofetch cowsay nyancat
  echo "Installing exa..."
  if ! [ "$(command -v exa)" ]; then
    cargo install exa
  fi
  echo "Installing bat..."
  if ! [ "$(command -v bat)" ]; then
    cargo install bat
  fi
  echo "Installing ripgrep..."
  if ! [ "$(command -v rg)" ]; then
    cargo install ripgrep
  fi
  echo "Installing fd..."
  if ! [ "$(command -v fd)" ]; then
    cargo install fd-find
  fi
  echo "Installing bottom..."
  if ! [ "$(command -v btm)" ]; then
    cargo install bottom
  fi
  echo "Installing grex..."
  if ! [ "$(command -v grex)" ]; then
    cargo install grex
  fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  bootstrap;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    bootstrap;
  fi;
fi;
unset bootstrap;
source ~/.bashrc;
