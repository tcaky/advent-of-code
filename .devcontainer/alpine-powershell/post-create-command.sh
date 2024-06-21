#!/bin/sh


if [[ "1" -eq "1" ]]; then
    # install the requirements
    sudo apk add --no-cache \
        ca-certificates \
        less \
        ncurses-terminfo-base \
        krb5-libs \
        libgcc \
        libintl \
        libssl3 \
        libstdc++ \
        tzdata \
        userspace-rcu \
        zlib \
        icu-libs \
        curl

    sudo apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
        lttng-ust
    PWSH_VER='7.4.3'
    # Download the powershell '.tar.gz' archive
    curl -L "https://github.com/PowerShell/PowerShell/releases/download/v$PWSH_VER/powershell-$PWSH_VER-linux-musl-x64.tar.gz" -o /tmp/powershell.tar.gz

    # Create the target folder where powershell will be placed
    sudo mkdir -p /opt/microsoft/powershell/7

    # Expand powershell to the target folder
    sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

    # Set execute permissions
    sudo chmod +x /opt/microsoft/powershell/7/pwsh

    # Create the symbolic link that points to pwsh
    sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

    # Start PowerShell
    # pwsh




    echo "Ensure pwsh is in /etc/shells"
    PWSH_PATH=$(sudo which pwsh)
    echo "PWSH_PATH=$PWSH_PATH"
    grep -x $PWSH_PATH /etc/shells || sudo sh -c "echo $PWSH_PATH >> /etc/shells"
    echo "switch shell to pwsh"
    # sudo chsh vscode -s $PWSH_PATH
fi