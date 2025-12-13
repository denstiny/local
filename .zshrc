# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git env)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 
export HOMEBREW_NO_ENV_HINTS=1

[[ -s "/Users/mac/.gvm/scripts/gvm" ]] && source "/Users/mac/.gvm/scripts/gvm"

# 自动切换golang版本
# _change_go_version() {
#   if [ -f "go.mod" ]; then
#     local version=(`grep -Po "^go \K([0-9\.]*)$" go.mod`)
#     gvm use ${version}
#   fi
# }
# chpwd()
# {
#   _change_go_version
# }

#alias
alias re=yazi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Go 安装路径 (官方 pkg 安装默认为 /usr/local/go/bin)
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.cargo/bin

# 你的 Go 工作区 (默认即为 $HOME/go)
export GOPATH=$HOME/Workspace/go
# 将 Go 工作区的 bin 目录也加入 PATH，以便运行 go install 的工具
export PATH=$PATH:$GOPATH/bin
# 基础版：搜索当前目录下含 "关键词" 的行，fzf筛选后用nvim打开并跳转到对应行
#
# fzf + grep/rg + nvim 精准跳转文件行号
# 用法：
#   fzfnv [关键词]                # 基础搜索（默认rg，无则用grep）
#   fzfnv [关键词] --type lua,js  # 只搜索lua/js文件
#   fzfnv [关键词] --exclude dir1,dir2  # 排除指定目录
#   fzfnv [关键词] --tool grep    # 强制使用grep（默认rg）
function fzfnv() {
    # 1. 参数校验（无关键词则提示用法）
    if [[ $# -eq 0 ]]; then
        echo "用法：fzfnv <搜索关键词> [可选参数]"
        echo "  可选参数："
        echo "    --type <后缀>      只搜索指定类型文件（如 lua,js,py）"
        echo "    --exclude <目录>   排除指定目录（如 node_modules,.git）"
        echo "    --tool <grep|rg>   指定搜索工具（默认优先rg，无则用grep）"
        echo "  示例："
        echo "    fzfnv func --type lua,js"
        echo "    fzfnv ERROR --exclude node_modules,.git --tool grep"
        return 1
    fi

    # 2. 初始化默认配置
    local keyword="$1"
    local search_tool="rg"  # 默认优先用ripgrep（更快）
    local include_types=""  # 要包含的文件类型（如 *.lua,*.js）
    local exclude_dirs=("node_modules" ".git" "venv" "dist")  # 默认排除的目录
    local preview_cmd=""    # 预览命令（优先用bat，无则用cat）

    # 3. 解析可选参数（--type/--exclude/--tool）
    shift  # 跳过第一个参数（关键词）
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --type)
                shift
                # 将逗号分隔的后缀转为 grep/rg 支持的格式
                include_types=$(echo "$1" | tr ',' '|' | sed 's/^/\*\./g')
                ;;
            --exclude)
                shift
                # 追加自定义排除目录
                exclude_dirs+=($(echo "$1" | tr ',' ' '))
                ;;
            --tool)
                shift
                search_tool="$1"
                ;;
            *)
                echo "未知参数：$1"
                return 1
                ;;
        esac
        shift
    done

    # 4. 检查搜索工具是否存在（rg不存在则自动切grep）
    if [[ $search_tool == "rg" && ! $(command -v rg) ]]; then
        echo "提示：未安装ripgrep，自动切换为grep"
        search_tool="grep"
    fi
    if [[ ! $(command -v $search_tool) ]]; then
        echo "错误：未找到 $search_tool，请先安装"
        return 1
    fi

    # 5. 构建搜索命令（区分rg/grep）
    local search_cmd=""
    if [[ $search_tool == "rg" ]]; then
        # rg 配置：行号+忽略大小写+排除目录+指定文件类型
        search_cmd="rg -n -i "
        # 添加排除目录
        for dir in "${exclude_dirs[@]}"; do
            search_cmd+="--glob '!$dir/**' "
        done
        # 添加指定文件类型
        if [[ -n $include_types ]]; then
            search_cmd+="--glob '{$include_types}' "
        fi
        search_cmd+="'$keyword' ."
    else
        # grep 配置：递归+行号+忽略大小写+排除目录+指定文件类型
        search_cmd="grep -rin -i "
        # 添加排除目录
        for dir in "${exclude_dirs[@]}"; do
            search_cmd+="--exclude-dir='$dir' "
        done
        # 添加指定文件类型
        if [[ -n $include_types ]]; then
            search_cmd+="--include=*.$(echo "$include_types" | tr '|' ' ' | sed 's/\*\.//g') "
        fi
        search_cmd+="'$keyword' ."
    fi

    # 6. 构建预览命令（优先bat，无则用cat）
    if [[ $(command -v bat) ]]; then
        preview_cmd="bat --style=numbers --color=always {1} --highlight-line {2}"
    else
        preview_cmd="cat -n {1} | grep -A 5 -B 5 ^{2} | sed 's/^[ \t]*//'"
    fi

    # 7. 核心逻辑：搜索 → fzf筛选 → nvim跳转
    eval $search_cmd | fzf \
        --delimiter ':' \
        --preview "$preview_cmd" \
        --preview-window 'right:60%' \
        --bind 'esc:abort' \
        --height 80% \
        | awk -F ':' '{print $1 " +" $2}' \
        | xargs -r nvim  # -r：无结果时不执行nvim

    # 8. 无匹配结果时提示
    if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
        echo "未找到匹配 '$keyword' 的内容"
    fi
}

# 可选：添加简写别名（更易用）
alias fnv="fzfnv"

# translate-shell 双向翻译函数（关闭自动更正提示）
function trans-auto() {
    # 检测输入文本的语言（提取语言代码，如 zh/en）
    local src_lang=$(trans -identify -b -no-auto "$1" | cut -d':' -f1 | cut -d',' -f1 | tr '[:upper:]' '[:lower:]')
    
    # 根据源语言切换目标语言，添加 -no-auto -quiet 关闭冗余提示
    if [[ $src_lang == *"zh"* ]]; then
        # 中文 → 英文（关闭自动更正+精简输出）
        trans -b -no-auto -quiet -e google zh:en "$1"
    elif [[ $src_lang == *"en"* ]]; then
        # 英文 → 中文
        trans -b -no-auto -quiet -e google en:zh "$1"
    else
        # 其他语言 → 中文
        trans -b -no-auto -quiet -e google auto:zh "$1"
    fi
}

alias cargo_test="cargo pretty-test --color=always"
export RUST_BACKTRACE=1
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/mac/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
alias box=devbox
