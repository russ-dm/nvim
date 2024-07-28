require("config.lazy")

-- default colorscheme or fallback
vim.g.SCHEME = "patana"

vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    pcall(vim.cmd.colorscheme, vim.g.SCHEME)
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(params)
    vim.g.SCHEME = params.match
  end,
})

-- local lush = require "lush"
-- local base = require "zenbones"
-- local palette = require "zenbones.palette"
--
-- -- Create some specs
-- local specs = lush.parse(function(injected_functions)
-- 	local sym = injected_functions.sym
-- 	return {
-- 		sym "@lsp.type.keyword" { base["@constant"], bg = palette.light.water },
-- 	}
-- end)
-- -- Apply specs using lush tool-chain
-- lush.apply(lush.compile(specs))

vim.api.nvim_set_hl(0, "@lsp.mod.mutable.rust", { underdouble = true }) --underline = true })
