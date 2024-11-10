# Put files in this folder to add your own custom functionality.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Customization
#
# Files in the custom/ directory will be:
# - loaded automatically by the init script, in alphabetical order
# - loaded last, after all built-ins in the lib/ directory, to override them
# - ignored by git by default
#
# Example: add custom/shortcuts.zsh for shortcuts to your local projects
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr

# aliases
alias c=clear
alias bcat=batcat
alias v=nvim
alias mkdir=mkdir -p

# autosuggest settings
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

bindkey ';' autosuggest-accept
bindkey ';;' autosuggest-execute
