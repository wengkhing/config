# Auto-completion for saws
complete -c saws -f
complete -c saws -a "(grep -E '^\[profile.*\]' ~/.aws/config 2>/dev/null | sed 's/^\[profile //g' | sed 's/\]\$//g')"