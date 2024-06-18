#!/bin/sh
echo "Ensure pwsh is in /etc/shells"
PWSH_PATH=$(sudo which pwsh)
echo "PWSH_PATH=$PWSH_PATH"
grep -x $PWSH_PATH /etc/shells || sudo sh -c "echo $PWSH_PATH >> /etc/shells"
echo "switch shell to pwsh"
sudo chsh vscode -s $PWSH_PATH