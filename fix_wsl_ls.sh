touch ~/.test.txt
echo "LS_COLORS=\"ow=01;36;40\" && export LS_COLORS
> zstyle ':completion:*' list-colors \"\${(@s.:.)LS_COLORS}\"
> autoload -Uz compinit
> compinit" > ~/.test.txt