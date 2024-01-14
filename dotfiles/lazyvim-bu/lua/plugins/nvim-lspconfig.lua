return {
  "neovim/nvim-lspconfig",
  opts = {
    setup = {
      astro = function(_, opts)
        require("lspconfig").astro.setup({
          init_options = {
            typescript = {
              serverPath = "/home/tjbo/.nix-profile/bin/typescript-language-server",
            },
          },
        })
        return true
      end,
    },
  },
}
