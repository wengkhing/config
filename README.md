# Dotfiles

Mac configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## New Machine Setup

```bash
git clone git@github.com:wengkhing/config.git ~/code/config
cd ~/code/config
./setup.sh
```

`setup.sh` will:
- Install Homebrew (if missing)
- Install all packages from `Brewfile`
- Back up any conflicting configs
- Symlink all packages via `stow`
- Set fish as default shell

## Packages

| Package | Config path |
|---------|------------|
| alacritty | `~/.config/alacritty/alacritty.toml` |
| bash | `~/.bash_profile` |
| fish | `~/.config/fish/{config.fish,functions/,completions/}` |
| gh | `~/.config/gh/{config.yml,hosts.yml}` |
| git | `~/.gitconfig`, `~/.config/git/ignore` |
| mise | `~/.config/mise/config.toml` |
| nvim | `~/.config/nvim/` |
| spotify-player | `~/.config/spotify-player/app.toml` |
| starship | `~/.config/starship.toml` |
| zellij | `~/.config/zellij/config.kdl` |

## Usage

**Stow a package:** `stow -t ~ <package>`

**Unstow a package:** `stow -D -t ~ <package>`

**Add a new tool:**
```bash
mkdir -p <tool>/.config/<tool>/
cp ~/.config/<tool>/config.toml <tool>/.config/<tool>/
rm ~/.config/<tool>/config.toml
stow -t ~ <tool>
```

**Edit configs in place** — symlinks mean changes in `~/.config/` are already in the repo.
