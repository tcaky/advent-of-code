FROM mcr.microsoft.com/devcontainers/base:alpine-3.20 AS alpine_pwsh

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"
# [Option] Enable non-root Docker access in container
# ARG ENABLE_NONROOT_DOCKER="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# These are executing as root, so no `sudo` needed.
RUN apk update

# RUN apk add zsh-theme-powerlevel10k 

# adjust timezone
RUN apk add tzdata
RUN ln -s /usr/share/zoneinfo/America/Toronto /etc/localtime


RUN apk add tmux neovim powershell ripgrep
# lazygit ripgrep alpine-sdk

# RUN apk add py-pip npm nodejs cargo ripgrep lazygit starship fontforge py3-configargparse


# Switch to non-root user
USER ${USERNAME}

RUN mkdir -p ~/.local/share/zsh/plugins
RUN mkdir -p ~/.local/share/nvim
RUN mkdir -p ~/.local/state
