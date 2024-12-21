return {
  "conneroisu/doppler.nvim",
  -- dir = "~/Documents/001Repos/doppler.nvim",
  event = "VeryLazy",
  opts = {
    scope = "~/dotfiles/.config/nvim",
    variables = {
      openai_api_key = "OPENAI_API_KEY",
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
