# Notes
## Motions 
Just a list of motions I'd like to use more often
in my daily text navigation workflows to make myself more
efficient in VIM control.

## Anatomy of a Motion
- command
- count 
- motion

### `vi{` and `va{`
- these  will select then next function block in visual mode
- very useful for changing everything within a block of code
- vi will select the inside whereas va will also select the
brackets themselves
- once selected we can use o to jump up and down on
selection
- we can use `<S-v>` to select full line of all selection
- works with yank, `ya{`
- works with change,`ci{`
- and of course delete, `da{`
- `viw` also useful
- `yiW` backwards

###  `F, b, r`
- `F` does same things a `f` only backwards
- `b` goes backwards by word
- `r` replaces whatever is under cursor with next keypress
- when using f, we can use `:` to repeat forward and `,` to
go backwardk

### screen nav
- `<C-d>` = down 1/2 screen
- `<C-u>` = up 1/2 screen
- `<C-f>` = forward 1 screen
- `<C-b>` = back 1 screen

### `?`
- searches reverse
- <S-n> will reverse search
- <S-*> will load word into search that cursor is one

### `d$`
- this would delete to end of cursor
- we can combine these more often

### `dfe`
- this would delete up to the letter e

### `cfe`
- this would do same except we would end up
in insert mode

### `yfx`
- would yank up until the character x

## `vfx`
- visual mode selects until x

## `I` and `A`
- go to the beginning and end of a line in insert mode

## `o` and `O`
- will go into insert mode relative to the current line

https://github.com/ThePrimeagen/vim-be-good

## `:e`
- will give you prompt to create file
