-- ~/.config/nvim/lua/plugins/lint.lua
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        marksman = {
          args = {
            { "--disable", "MD013", "--" },
            { "--disable", "MD003", "--" },
          },
        },
      },
    },
  },
}
