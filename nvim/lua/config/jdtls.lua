local config = {
	root_dir = function(fname)
		return require("jdtls.setup").find_root({
			".git",
			"mvnw",
			"gradlew",
			".project",
		}) or vim.fn.getcwd()
	end,
}
