return {
  'pwntester/octo.nvim',
  Event = 'UIEnter',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function ()
    require"octo".setup()
  end,
  lazy = true,
}
