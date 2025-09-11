return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/obsidian-vault",
			},
			{
				name = "work",
				path = "~/Documents/obsidian-vault-work",
			},
		},
		ui = { enable = false },
		templates = {
			folder = "templates",
			date_format = "%d-%m-%Y",
			time_format = "%H:%M",
		},
		picker = {
			name = "telescope.nvim",
		},

		note_frontmatter_func = function(note)
			local slug = note.title
			if slug then
				-- replace spaces with dashes, lowercase it
				slug = slug:gsub("%s+", "-"):lower()
			end

			local out = {
				id = note.id,
				aliases = slug or {},
				tags = note.tags,
				date = os.date("%d-%m-%Y %H:%M"), -- matches your template format
			}
			return out
		end,
	},
}
