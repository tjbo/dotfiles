# one way to figure out how to bind shortcut keys in ZSH
# is to "cat" and then press short cut

# bindkey -M viins -rp ''
# bindkey "^D" list-choices
# bindkey "^E" end-of-line
# bindkey "^F" forward-char
# bindkey "^G" list-expand
# bindkey "^H" vi-backward-delete-char
# bindkey "^I" expand-or-complete
# bindkey "^J" accept-line
bindkey "^K" zvm_forward_kill_line
bindkey "^L" clear-screen
# bindkey "^M" accept-line
bindkey "^N" down-line-or-history
# bindkey "^O" self-insert
bindkey "^P" up-line-or-history
bindkey "^Q" vi-quoted-insert
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# bindkey "^T" self-insert
# bindkey "^U" zvm_viins_undo
bindkey "^V" vi-quoted-insert
# bindkey "^W" backward-kill-word
# bindkey "^Y" yank
# bindkey "^Z" self-insert
bindkey "^[" zvm_readkeys_handler
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history
bindkey "^[OC" vi-forward-char
bindkey "^[OD" vi-backward-char
bindkey "^[[200~" bracketed-paste
bindkey "^[[3~" delete-char
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history
# bindkey "^[[C" vi-forward-char
# bindkey "^[[D" vi-backward-char
# bindkey "^[[F" end-of-line
# bindkey "^[[H" beginning-of-line
bindkey "^[c" self-insert
# bindkey "^[d" fzf-cd-widget
# bindkey "^[e" edit-command-line
# bindkey "^[f" fzf-file-widget
# bindkey "^[h" fzf-history-widget
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


