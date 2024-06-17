#!/bin/sh

sudo ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime


sudo chsh vscode -s \"$(which pwsh)\"