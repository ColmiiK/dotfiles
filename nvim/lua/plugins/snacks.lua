return {
	{
		"folke/snacks.nvim",
		opts = {
			explorer = { enabled = true }, -- activate explorer
			picker = {
				sources = {
					explorer = {
						layout = {
							layout = { position = "right" }, -- this places the explorer picker on the right
						},
						hidden = true,
						ignored = true,
						win = {
							list = {
								-- optional list-specific config
							},
						},
					},
				},
			},
		},
		keys = {
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "Open Snacks Explorer",
			},
		},
	},
}
