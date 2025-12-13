# mac install local config script

brew install python
brew install golang
brew install neovim
brew install zshrc
brew install npm
brew install yazi

CURRENT_DIR=$(cd "$(dirname "${CURRENT_FILE}")" && pwd -P)
# [zsh]
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 
brew install autojump
brew install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions 
git clone https://github.com/johnhamelink/env-zsh.git ~/.oh-my-zsh/plugins/env
ln -s $CURRENT_DIR/.zshrc ~/.zshrc

source ~/.zshrc 

#[config]
ln -s $CURRENT_DIR/yazi ~/.config/yazi
ln -s $CURRENT_DIR/wezterm ~/.config/wezterm
ln -s $CURRENT_DIR/nvim ~/.config/nvim
