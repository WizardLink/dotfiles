### export {{{
export EDITOR=vim

export OSH=/c/Users/Usuario/.oh-my-bash
### }}}

### ohmybash {{{
OSH_THEME="custom"

completions=(
	composer
	git
	ssh
	system
)

source $OSH/oh-my-bash.sh
### }}}

### alias {{{
alias bashconfig="$EDITOR ~/.bashrc"
alias bashreload="source ~/.bashrc"
alias vimrc="vim ~/.vimrc"
### }}}
