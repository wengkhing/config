# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/wengkhing/.docker/bin"
# End of Docker Desktop section.

if status is-interactive
# Commands to run in interactive sessions can go here
end
starship init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null
