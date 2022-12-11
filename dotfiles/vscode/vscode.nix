{
  # enable=true;  
  # userSettings = {
  # keyboard.dispatch= "keyCode";
  # vim.leader=  "<escape>";
  # };
  keybindings = [
    {
      key = "capslock";
      command = "extension.vim_escape";
      when = "textInputFocuseditorTextFocus && vim.active && !inDebugRepl";
    }
  ];
}
