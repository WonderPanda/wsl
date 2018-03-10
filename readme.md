# A Complete Setup Script for Configuring WSL

## Why should you use this
todo

## What's included
todo

## Running the script
WSL conveniently comes with wget already installed. This makes it easy to pull down the script directly from GitHub and run it. After dropping into WSL from the command line, just use the following command in your home directory:

`wget https://raw.githubusercontent.com/WonderPanda/wsl/master/wsl-setup.sh`

In order to execute the downloaded file as a script, we have to modify it's permissions.

`chmod +x ./wsl-setup.sh`

Now just execute the script

`./wsl-setup.sh`