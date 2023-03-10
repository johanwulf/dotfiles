# Import aliases common for work/private
if [ -f ~/.config/.zsh_common ]; then
    source ~/.config/.zsh_common
fi

# Import aliases related to work
if [ -f ~/.config/.zsh_work ]; then
    source ~/.config/.zsh_work
fi

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Install plugins
if [[ ! -d "$HOME/.config/zsh_plugins/zsh-autosuggestions/" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh_plugins/zsh-autosuggestions
fi


if [[ ! -d "$HOME/.config/zsh_plugins/zsh-syntax-highlighting/" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh_plugins/zsh-syntax-highlighting
fi

source ~/.config/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function journal() {
    date=$1
    year=$(date -d "$date" +%Y)
    month=$(date -d "$date" +%m-%B | tr '[:upper:]' '[:lower:]')
    day=$(date -d "$date" +%d)
    dir="$HOME/journal/$year/$month"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
    file="$dir/$day.md"
    sed "1s/# Date/# $date/" "$HOME/journal/TEMPLATE.md" > "$file"
    nvim "$file"
}

