return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    ---@param opts table
    config = function(_, opts)
      vim.o.background = "dark"
      require("solarized").setup(opts)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
