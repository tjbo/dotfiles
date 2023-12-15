# Useful
# 1. zle -al = list all registered zle commands 
# 2. https://wiki.zshell.dev/docs/guides/syntax/bindkey
# 3. figure out a key, "cat" and then press short cut key

bindkey -r "^A" 
bindkey -r "^B"
bindkey -r "^C" 
bindkey -r "^D"
bindkey -r "^E"
bindkey -r "^F"
bindkey -r "^G"
bindkey -r "^H"
bindkey -r "^I"
bindkey -r "^J"
bindkey -r "^K"
# bindkey "^K" zvm_forward_kill_line
bindkey "^L" clear-screen
bindkey -r "^M" 
bindkey "^N" down-line-or-history
# bindkey "^O" self-insert
bindkey "^P" up-line-or-history
bindkey "^Q" vi-quoted-insert
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# bindkey "^T" self-insert // if we delete this does it still work in nvim? 
bindkey -r "^T"
bindkey -r "^U"
bindkey -r "^V"
bindkey -r "^v"
# bindkey "^V" vi-quoted-insert
bindkey -r "^W"
bindkey -r "^Y"
# bindkey "^Y" yank
bindkey -r "^Z"
bindkey "^[" zvm_readkeys_handler
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history
bindkey "^[OC" vi-forward-char
bindkey "^[OD" vi-backward-char
bindkey "^[[200~" bracketed-paste
bindkey "^[[3~" delete-char
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
bindkey "^[c" self-insert
bindkey "^[l" clear-screen
bindkey -R "^\\\\"-"^\^" self-insert
bindkey "^_" undo
bindkey -R " "-"~" self-insert
bindkey "^?" backward-delete-char
bindkey -R "\M-^@"-"\M-^?" self-insert

zvm_bindkey viins '^[p' up-line-or-history
zvm_bindkey viins '^[n' down-line-or-history

# bindkey -M viins '^[c' self-insert
# bindkey -M viins '^[e' edit-command-line
# bindkey -M viins '^[l' clear-screen 


