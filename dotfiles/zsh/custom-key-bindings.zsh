# one way to figure out how to bind shortcut keys in ZSH
# is to "cat" and then press short cut
zvm_bindkey viins '^[p' up-line-or-history
zvm_bindkey viins '^[n' down-line-or-history

bindkey -M viins '^[l' clear-screen 
bindkey -M viins '^[c' self-insert
bindkey -M viins '^[e' edit-command-line

# fzf shortcuts
bindkey -M viins '^[h' fzf-history-widget
bindkey -M viins '^[d' fzf-cd-widget
bindkey -M viins '^[f' fzf-file-widget
