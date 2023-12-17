with import <nixpkgs> { };

{
  configFile.source = ./config.nu;
  enable = true;
}
