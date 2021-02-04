#!/usr/bin/env bash

git pull origin master;

function bootstrap() {
  rsync --exclude ".git/" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "LICENSE" \
    -avh --no-perms . ~;
  source ~/.bash_profile;
  install;
}

function install() {
  # Install Starship
  if ! [ "$(command -v starship)" ]; then
        curl -fsSL https://starship.rs/install.sh | bash;
  fi
  # Install NVM & Latest Node
  if ! [ "$(command -v nvm)" ]; then
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash;
      nvm use;
  fi
  # Install GH CLI client
  if ! [ "$(command -v gh)" ]; then
      sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0;
      sudo apt-add-repository https://cli.github.com/packages;
      sudo apt update;
      sudo apt install gh;
  fi
  # Install Rust
  if ! [ "$(command -v rustup)" ]; then
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;
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
unset install;
