-- test config

-- Load `lazy.nvim`:
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{'windwp/nvim-autopairs', -- close brackets automatically
		dir = '~/Projects/nvim-autopairs',
		event = 'InsertEnter',
		config = function()
			local nap = require('nvim-autopairs')
			local rule = require('nvim-autopairs.rule')
			-- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa --
			--                aaa   bbb   cccc   a.b.c    c.c.c   x-y,z   --
			nap.setup({
				--ignore_next_char = "",
				--disable_in_macro = false,
			})
			nap.clear_rules()
			nap.add_rules {
				rule('(', ')')
			}
			-- nap.get_rules("'")[1].not_filetypes = {
			-- 	-- disable pairing ' in filetypes:
			-- 	'tex',
			-- 	'text',
			-- }
			-- nap.add_rules {
			-- 	rule('$', '$', {'tex', 'typst'}),
			-- 	rule('(', ')'),
			-- 	rule('[', ']'),
			-- 	rule('{', '}'),
			-- 	rule('"', '"'),
			-- 	rule('`', '', {'lean'}),
			-- }
		end
	},
})

