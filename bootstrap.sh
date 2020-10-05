#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
    # Install Starship
	if ! [ -x "$(command -v starship)" ]; then
  	    curl -fsSL https://starship.rs/install.sh | bash;
	fi
    # Install NVM & Latest Node
    if ! [ -x "$(command -v nvm)" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash;
        nvm install node;
    fi
    # Install GH CLI client
    if ! [ -x "$(command -v gh)" ]; then
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0;
        sudo apt-add-repository https://cli.github.com/packages;
        sudo apt update;
        sudo apt install gh;
    fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
