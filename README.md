# Code Capsule

![Code Capsule Logo](https://github.com/shano/code-capsule/blob/main/logo.png)

The aim of this project is to provide an encapsulated development environment within a container.

It installs various resources for development, and mounts a persistent home directory. Nothing everything is in IAC and that's intentional.

Here are a few shell aliases that will help with working with this.

```bash
alias docker-start="colima start --memory 8 --mount $HOME:w"
alias ubuntu-start="docker-compose -f $HOME/path/to/project/docker-compose.yml up -d"
alias ubuntu-stop="docker-compose -f $HOME/path/to/project/docker-compose.yml down"
alias ubuntu-shell="docker exec -it -u user $(docker-compose -f $HOME/path/to/project/docker-compose.yml ps -q ubuntu) /bin/zsh"
alias ubuntu-build="cd $HOME/path/to/project && docker-compose build && cd -"
```
