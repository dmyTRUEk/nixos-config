----- dmyTRUEk's NeoVim config file -----

function print_table(table)
	print(vim.inspect(table))
end



--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.o.number = true -- line number
vim.o.relativenumber = true -- + relative line number

vim.o.cursorline = true -- highlight cursor line
--'cursorcolumn' -- highlight cursor column
--'termguicolors' -- ?
--'showmatch' -- shows matching brackets
--'autochdir' -- change current dir to file's dir (folder directory)
--'showcmd' -- ? show last command (if you pressed 'j' then 'j' will be showed)

--'incsearch',
--'hlsearch',

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

--'noexpandtab',
local TAB_SIZE = 4
vim.o.tabstop = TAB_SIZE -- size of tab used for "rendering"
vim.o.shiftwidth = TAB_SIZE -- size of tab used for << >> etc

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


-- TODO: disable?
vim.o.linebreak = true -- wrap on words (wrap on chars in `breakat`)

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

--'langremap', -- ?

--vim_opt_disable 'modeline'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.encoding = 'utf-8'
-- vim.o.filetype = 'on'

-- TODO: remove?
vim.o.laststatus = 2 -- when/how to display status-bar: 0=never, 1={if > than 2 windows}, 2=always
vim.o.virtualedit = 'block'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10 -- TODO: use relative

--timeoutlen = 1000,
--ttimeoutlen = 0,

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

vim.o.redrawtime = 10000 -- for giant files

--cmdheight = 0, -- TODO: enable

-- use ukr in normal mode
vim.o.langmap = [[йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\;,є',яz,чx,сc,мv,иb,тn,ьm,б\,,ю.,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Є",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>]]

-- Don't show the mode, since it's already in the status line
vim.o.showmode = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true



vim.g.relative_scrolloff_percentage = 30
function set_relative_scrolloff(fraction)
	-- TODO
end





keymap = function(mode, keys, action)
	if type(keys) == 'table' then
		for _, k in ipairs(keys) do
			vim.keymap.set(mode, k, action)
		end
	else
		vim.keymap.set(mode, keys, action)
	end
end

keymap_n = function(keys, action) keymap('n', keys, action) end
keymap_v = function(keys, action) keymap('v', keys, action) end
keymap_i = function(keys, action) keymap('i', keys, action) end
keymap_nv = function(keys, action) keymap_n(keys, action) keymap_v(keys, action) end
keymap_n_cmd = function(keys, cmd) keymap_n(keys, '<cmd>' .. cmd .. '<cr>') end

keymap_swap_n = function(k1, k2) vim.keymap.set('n', k1, k2) vim.keymap.set('n', k2, k1) end
keymap_swap_v = function(k1, k2) vim.keymap.set('v', k1, k2) vim.keymap.set('v', k2, k1) end
keymap_swap_nv = function(k1, k2) keymap_swap_n(k1, k2) keymap_swap_v(k1, k2) end



keymap_swap_nv('0', '^')
keymap_swap_nv("'", '`')

keymap_nv({'<c-j>', '<c-о>'}, '<c-d>zz') -- better move half-page down
keymap_nv({'<c-k>', '<c-л>'}, '<c-u>zz') -- better move half-page up
keymap_nv({'<c-n>', '<c-т>'}, '%')
-- keymap_nv('<c-/>', 'gc') -- TODO

keymap_n('Q', '') -- unmap ex mode
keymap_n({'U', 'Г'}, '<c-r>') -- better redo
keymap_n({'Y', 'Н'}, 'y$') -- better copy till end of line
keymap_n('-', '$') -- better $
keymap_n({'<c-p>', '<c-з>'}, '$p') -- paste at end of line
keymap_n({'<a-p>', '<a-з>'}, '^P') -- paste at begin of line

-- "fix" `h` & `l` motions:
keymap_n('ch', 'lc2h') keymap_n('cl', 'c2l')
keymap_n('dh', 'ld2h') keymap_n('dl', 'd2l')
keymap_n('yh', 'ly2h') keymap_n('yl', 'y2l')

-- "fix" `b` motion:
-- cb = 'cb<DEL>', TODO

-- `f` & `t` from end of line
-- keymap_n('gf', '$F')
-- keymap_n('gt', '$T')

-- work with function names:
keymap_n('cn', 'ct(') keymap_n('dn', 'dt(') keymap_n('yn', 'yt(')
keymap_n('cu', 'ct_') keymap_n('du', 'df_') keymap_n('yu', 'yt_')

keymap_n('c;', 'ct;')
keymap_n('d;', 'dt;')
keymap_n('y;', 'yt;')

keymap_n('<leader>;', 'm`A;<esc>``')
keymap_n('<leader>:', 'm`A:<esc>``')
keymap_n('<leader>,', 'm`A,<esc>``')
keymap_n({'<leader>.', '<leader>ю'}, 'm`A.<esc>``')
keymap_n({'<leader>e', '<leader>у'}, 'm`$x``')

-- TODO: make one more plugin? :3
-- my Change Current word with another (aka `viwy`):

-- `cc` is duplication of `S`, so we can use it for our purposes, so firstly we clearing it
keymap_n('cc', '')

-- map `cc<move>` to Change Current word with MOVE word
-- this solution is better than `df<space>f<space>p` because it might not work if
-- there is no space after second word (eg `,` `)` `\n` etc)

-- TODO?: figure out better way to do this, so it works at least for `f<symbol>` or even any move
-- TODO: fix it for ukr

-- here `|` means cursor position
keymap_n('ccw', 'yiwwviwp2bviwp') -- a|aa bbb -> bbb| aaa
keymap_n('ccW', 'yiWWviWp2BviWp') -- aaa.a|aa bbb.bbb -> bbb.bbb| aaa.aaa

keymap_n('ccb', 'yiwbviwpwviwp') -- aaa b|bb -> bbb aaa|
keymap_n('ccB', 'yiWBviWpWviWp') -- aaa.aaa bbb.b|bb -> bbb.bbb aaa.aaa|

keymap_n('cc2w', 'yiw2wviwp3bviwp')
keymap_n('cc2W', 'yiW2WviWp3BviWp')
keymap_n('cc2b', 'yiw2bviwp2wviwp')
keymap_n('cc2B', 'yiW2BviWp2WviWp')

keymap_n('cc3w', 'yiw3wviwp4bviwp')
keymap_n('cc3b', 'yiw3bviwp3wviwp')
keymap_n('cc3W', 'yiW3WviWp4BviWp')
keymap_n('cc3B', 'yiW3BviWp3WviWp')

keymap_n('<c-cr>', '<c-6>') -- goto to prev file(buffer?)

-- TODO?: add `zb` == `zw`: spelling bad/wrong

keymap_n('g/m', '/<<<<<<<\\|=======\\|>>>>>>><cr>') -- TODO: only for `.diff` file?

keymap_n('пс', '<Plug>Commentary')
keymap_n('псс', '<Plug>CommentaryLine') -- comments (gcc)

keymap_n('<c-щ>', '<c-o>')
keymap_n('<c-ш>', '<c-i>')

-- Diagnostic keymaps
keymap_n('<leader>x', vim.diagnostic.setloclist) -- Open diagnostic quickfi[X] list

keymap_n('<down>', '<c-e>') -- move viewport down
keymap_n('<up>'  , '<c-y>') -- move viewport up



keymap_n_cmd({'<leader>q', '<leader>й'}, 'q')
keymap_n_cmd({'<leader>Q', '<leader>Й'}, 'qa')
keymap_n_cmd({'<leader>w', '<leader>ц'}, 'w')
keymap_n_cmd({'<leader>W', '<leader>Ц'}, 'wa')
keymap_n_cmd({'<leader>a', '<leader>ф'}, 'wq')
keymap_n_cmd({'<leader>A', '<leader>Ф'}, 'wqa')

keymap_n_cmd({'<leader>h', '<leader>р'}, 'wincmd h')
keymap_n_cmd({'<leader>j', '<leader>о'}, 'wincmd j')
keymap_n_cmd({'<leader>k', '<leader>л'}, 'wincmd k')
keymap_n_cmd({'<leader>l', '<leader>д'}, 'wincmd l')

keymap_n_cmd({'<leader>H', '<leader>Р'}, 'wincmd H')
keymap_n_cmd({'<leader>J', '<leader>О'}, 'wincmd J')
keymap_n_cmd({'<leader>K', '<leader>Л'}, 'wincmd K')
keymap_n_cmd({'<leader>L', '<leader>Д'}, 'wincmd L')

keymap_n_cmd('<leader><leader>', 'wincmd p')

keymap_n_cmd({'<leader>S', '<leader>І'}, 'setlocal spell!')

--<leader>v :call ToggleHorizontalVerticalSplit() <cr>

keymap_n_cmd('<esc>', 'nohlsearch') -- TODO: also remove red "E486: Pattern not found"

-- for quickfix list:
keymap_n_cmd('<c-9>', 'cprev')
keymap_n_cmd('<c-0>', 'cnext')
keymap_n_cmd('<c-q>', 'cclose')

keymap_n_cmd({'<c-t>', '<c-е>'}, 'tabnext')
keymap_n_cmd({'<c-y>', '<c-н>'}, 'tabprev')



keymap_i({'<c-;>', '<c-ж>'}, '')
keymap_i({'<c-h>', '<c-р>'}, '<left>')
keymap_i({'<c-j>', '<c-о>'}, '<down>')
keymap_i({'<c-k>', '<c-л>'}, '<up>')
keymap_i({'<c-l>', '<c-д>'}, '<right>')



keymap_v('-', '$h') -- better $
keymap_v({'S', 'І'}, ':sort<cr>')





vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'gitcommit',
		'markdown', -- .md
		'tex',
		'text', -- .txt
	},
	command = 'setlocal spell spelllang=uk,en'
})
--vim.api.nvim_create_autocmd({'BufEnter', 'BufLeave', 'BufWinEnter', 'BufWinLeave', 'WinNew', 'WinEnter', 'WinLeave', 'VimResized'}, {
--	callback = function()
--		--set_relative_scrolloff() -- TODO:
--	end
--})
vim.api.nvim_create_autocmd('FileType', {
	-- set tabs EVERYWHERE
	pattern = '*',
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = TAB_SIZE
		vim.opt_local.shiftwidth = TAB_SIZE
		--vim.opt_local.softtabstop = options.softtabstop
		--vim.opt_local.smarttab = true
	end
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'tex',
	callback = function()
		-- TODO: refactor
		require 'dmytruek.latex_autos'
		vim.cmd('call SetupEverythingForLatex()')
	end
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'text',
	callback = function()
		keymap_n('j', 'gj')
		keymap_n('k', 'gk')
	end
})
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end
})
vim.api.nvim_create_autocmd('WinEnter', {
	-- minimize quickfix list window height
	callback = function()
		local win = vim.api.nvim_get_current_win()
		vim.defer_fn(function()
			if vim.fn.getwininfo(win)[1].quickfix == 1 then
				local qf_list = vim.fn.getqflist()
				local qf_count = #qf_list
				local height = math.min(qf_count, 10)
				vim.api.nvim_win_set_height(win, height)
			end
		end, 10)
	end
})





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

-- PLUGINS:
require('lazy').setup({
	-- Colorschemes:
	--'ErichDonGubler/vim-sublime-monokai',
	--'nlknguyen/papercolor-theme',
	--'kjssad/quantum.vim',
	{'ellisonleao/gruvbox.nvim',
		opts = {
			overrides = {
				Operator = { link = 'GruvboxOrange' }, -- undo italic
				-- change diagnostic colors:
				DiagnosticHint = { link = 'GruvboxYellow' },
				DiagnosticSignHint = { link = 'GruvboxYellowSign' },
				DiagnosticUnderlineHint = { link = 'GruvboxYellowUnderline' },
				DiagnosticFloatingHint = { link = 'GruvboxYellow' },
				DiagnosticVirtualTextHint = { link = 'GruvboxYellow' },
				-- rust btw
				--['@lsp.type.comment.rust'] = { link = 'GruvboxYellow' },
				['@lsp.type.struct.rust'] = { link = 'GruvboxYellow' },
				-- TODO: special color for traits (interfaces).
				--['@lsp.type.interface.rust'] = { link = 'GruvboxOrange' },
				['@lsp.typemod.comment.documentation.rust'] = { link = 'GruvboxOrange' },
			},
		},
		init = function()
			-- require 'dmytruek.colorschemes.gruvbox'
		end,
		config = function()
			require('gruvbox').setup {
				styles = {
					-- comments = { italic = false }, -- Disable italics in comments
				},
			}
			vim.cmd.colorscheme 'gruvbox'
		end,
	},
	'rebelot/kanagawa.nvim',
	'catppuccin/nvim',
	--'projekt0n/github-nvim-theme',
	--'navarasu/onedark.nvim',
	'folke/tokyonight.nvim',

	-- MY CORE PLUGINS:
	{'windwp/nvim-autopairs', -- close brackets automatically
		config = true,
		init = function()
			local nap = require('nvim-autopairs')
			local rule = require('nvim-autopairs.rule')
			nap.get_rules("'")[1].not_filetypes = {
				'tex',
				'text',
			}
			nap.add_rules {
				rule('$', '$', {'tex', 'latex'}),
				rule('(', ')'),
				rule('[', ']'),
				rule('{', '}'),
				rule('"', '"'),
				rule('`', '', {'lean'}),
			}
		end
	},
	{'tpope/vim-surround', -- surround manager
		init = function()
			-- disable default keybinds:
			vim.g.surround_no_mappings = 1
			-- set custom maps:
			keymap_n({'ds', 'ві'}, '<Plug>Dsurround')
			keymap_n({'cs', 'сі'}, '<Plug>Csurround')
			keymap_n({'cS', 'сІ'}, '<Plug>CSurround')
			keymap_n({'ys', 'ні'}, '<Plug>Ysurround')
			keymap_n({'yS', 'нІ'}, '<Plug>YSurround')
			keymap_n({'yss', 'ніі'}, '<Plug>Yssurround')
			keymap_n({'ySs', 'нІі'}, '<Plug>YSsurround')
			keymap_n({'ySS', 'нІІ'}, '<Plug>YSsurround')
			keymap_v({'s', 'і'}, '<Plug>VSurround')
			keymap_v({'gs', 'пі'}, '<Plug>VgSurround')
			local function set(scope, char, surround_expression)
				vim[scope]['surround_'..vim.fn.char2nr(char)] = surround_expression
			end
			local function set_global(char, surround_expression)
				set('g', char, surround_expression)
			end
			local function set_local(char, surround_expression)
				set('b', char, surround_expression)
			end
			vim.api.nvim_create_autocmd('FileType', {
				pattern = '*',
				callback = function()
					-- new line:
					--set_global([[\<CR>]], '\n\t\r\n')
					--:echo char2nr("\<CR>") => 13
					vim.g.surround_13 = '\n\t\r\n'
					set_global('<', '<\r>')
					set_global('(', '(\r)')
					set_global('[', '[\r]')
					set_global('{', '{\r}')
					set_global(')', '( \r )')
					set_global(']', '[ \r ]')
					set_global('}', '{ \r }')
				end
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'markdown',
				callback = function()
					set_local('l', '[\r]()')
					set_local('L', '[](\r)')
				end
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'python',
				callback = function()
					set_local('e', 'enumerate(\r)')
					set_local('i', 'filter(\r)')
					set_local('I', 'Iterator[\r]')
					set_local('l', 'list(\r)')
					set_local('L', 'list[\r]')
					set_local('m', 'map(\r)')
					set_local('r', 'range(\r)')
					set_local('t', '\1Type: \1[\r]')
					set_local('T', 'tuple[\r]')
				end
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'rust',
				callback = function()
					local wrap_in_new  = '\1Container Type: \1::new(\r)'
					local wrap_in_type = '\1Container Type: \1<\r>'
					local wrap_in_ok   = 'Ok(\r)'
					set_local('b', 'Box::new(\r)')
					set_local('B', 'Box<\r>')
					set_local('c', wrap_in_new)
					set_local('C', wrap_in_type)
					set_local('d', 'dbg!(\r);')
					set_local('e', 'Err(\r)')
					--set_local('f', '\1function: \1\1(\r)')
					set_local('F', 'format!(\r)')
					set_local('i', 'if \1If statement: \1 {\n\t\r\n}')
					set_local('k', wrap_in_ok)
					set_local('m', '\1Macro name: \1!(\r)')
					set_local('n', wrap_in_new)
					set_local('o', wrap_in_ok)
					set_local('O', 'Option<\r>')
					set_local('r', 'Result<\r>')
					set_local('s', 'Some(\r)')
					set_local('t', wrap_in_new)
					set_local('T', wrap_in_type)
					set_local('v', 'vec![\r]')
					set_local('V', 'Vec<\r>')
				end
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'tex', -- LATEX
				callback = function()
					set_local('b', '\\textbf{\r}')
					set_local('c', '\\textcolor{red!50!black}{\r}')
					set_local('i', '\\textit{\r}')
					set_local('l', '\\\1Name: \1{\r}')
					set_local('L', '\\begin{\1Environment: \1}\r\\end{\1\1}')
					set_local('t', '\\text{\r}')
					set_local('u', '\\underline{\r}')
				end
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'lean',
				callback = function()
					set_local('c', '/-\r-/')
				end
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'html',
				callback = function()
					local function set_local_wrap_in_tag(key, tag)
						tag = tag or key -- default arg
						set_local(key, '<'..tag..'>\r</'..tag..'>')
					end
					set_local('a', '<a href="">\r</a>')
					set_local('c', '<!--\r-->')
					set_local_wrap_in_tag('1', 'h1')
					set_local_wrap_in_tag('2', 'h2')
					set_local_wrap_in_tag('3', 'h3')
					set_local_wrap_in_tag('4', 'h4')
					set_local_wrap_in_tag('5', 'h5')
					set_local_wrap_in_tag('6', 'h6')
					set_local_wrap_in_tag('b')
					set_local_wrap_in_tag('C', 'code')
					set_local_wrap_in_tag('d', 'div')
					set_local_wrap_in_tag('i')
					set_local_wrap_in_tag('l', 'li')
					set_local_wrap_in_tag('p')
					set_local_wrap_in_tag('s', 'small')
				end
			})
			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'lua',
				callback = function()
					set_local('i', 'vim.inspect(\r)')
				end
			})
		end
	},
	{'tommcdo/vim-exchange', -- exchange selections
		init = function()
			keymap_v('x', '<Plug>(Exchange)')
		end
	},
	'tpope/vim-repeat', -- enable repeat for plugins
	{'unblevable/quick-scope', -- better find in line
		-- TODO: remove?
		init = function()
			vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
		end
	},

	-- GENERAL PLUGINS:
	'tpope/vim-commentary', -- comments manager
	{'L3MON4D3/LuaSnip', -- snippets
		version = '2.*',
		-- opts = {},
		init = function()
			require('luasnip.loaders.from_snipmate').lazy_load()
			local ls = require 'luasnip'
			keymap_i('<F8>', ls.expand)
			keymap_i('<F9>', ls.expand)
			keymap_i('<F10>', ls.expand)
			-- vim.keymap.set({'i', 's'}, '<C-L>', function() ls.jump( 1) end, {silent = true})
			-- vim.keymap.set({'i', 's'}, '<C-J>', function() ls.jump(-1) end, {silent = true})
			-- vim.keymap.set({'i', 's'}, '<C-E>', function()
			-- 	if ls.choice_active() then
			-- 		ls.change_choice(1)
			-- 	end
			-- end, {silent = true})
		end
	},
	--'dmytruek/find-and-replace', -- find and replace
	{'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		init = function()
			local harpoon = require('harpoon')
			harpoon:setup({ default = { -- `harpoon:setup()` is required
				get_root_dir = function()
					local cwd = vim.loop.cwd()
					local root = vim.fn.system('git rev-parse --show-toplevel')
					if vim.v.shell_error == 0 and root ~= nil then
						return string.gsub(root, '\n', '')
					end
					return cwd
				end,
			}})
			keymap_n('<leader>H', function()
				local fname = vim.fn.expand('%:p')
				harpoon:list():add()
				print('`' .. fname .. '` harpooned >:3')
			end)
			keymap_n('<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
			keymap_n('<c-d>', function() harpoon:list():prev() end)
			keymap_n('<c-f>', function() harpoon:list():next() end)
			keymap_n('<c-1>', function() harpoon:list():select(1) end)
			keymap_n('<c-2>', function() harpoon:list():select(2) end)
			keymap_n('<c-3>', function() harpoon:list():select(3) end)
			keymap_n('<c-4>', function() harpoon:list():select(4) end)
			keymap_n('<c-5>', function() harpoon:list():select(5) end)
		end
	},
	{'lewis6991/gitsigns.nvim', -- Adds git related signs to the gutter, as well as utilities for managing changes.
		-- See `:help gitsigns` to understand what the configuration keys do.
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},
	{'nvim-telescope/telescope.nvim', -- TELESCOPE (fuzzy finder):
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzf-native.nvim',
		},
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup {
				defaults = {
					mappings = {
						i = {
							['<esc>'] = actions.close,
						},
					},
				},
				-- pickers = {}
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			}
			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')
			-- See `:help telescope.builtin`
			local builtin = require 'telescope.builtin'
			keymap_n({'<leader>b', '<leader>и'}, builtin.buffers) -- [ ] Find existing buffers
			keymap_n({'<leader>f', '<leader>а'}, builtin.find_files) -- [S]earch [F]iles
			keymap_n({'<leader>g', '<leader>п'}, builtin.live_grep) -- [S]earch by [G]rep
			keymap_n({'<leader>p', '<leader>з'}, builtin.colorscheme)
			keymap_n({'<leader>s', '<leader>і'}, builtin.spell_suggest)
			keymap_n({'<leader>u', '<leader>г'}, builtin.jumplist)
			-- keymap_n('<leader>ss', builtin.builtin) -- [S]earch [S]elect Telescope
			-- keymap_n('<leader>sd', builtin.diagnostics) -- [S]earch [D]iagnostics
			-- keymap_n('<leader>sw', builtin.grep_string) -- [S]earch current [W]ord
			-- keymap_n('<leader>sh', builtin.help_tags) -- [S]earch [H]elp
			-- keymap_n('<leader>sk', builtin.keymaps) -- [S]earch [K]eymaps
			-- keymap_n('<leader>s.', builtin.oldfiles) -- [S]earch Recent Files ("." for repeat)
			-- keymap_n('<leader>sr', builtin.resume) -- [S]earch [R]esume
			-- Example of overriding default behavior and theme
			keymap_n('<leader>/', function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end) --[/] Fuzzily search in current buffer
			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			-- vim.keymap.set('n', '<leader>s/', function()
			-- 	builtin.live_grep {
			-- 		grep_open_files = true,
			-- 		prompt_title = 'Live Grep in Open Files',
			-- 	}
			-- end, { desc = '[S]earch [/] in Open Files' })
			-- Shortcut for searching your Neovim configuration files
			-- vim.keymap.set('n', '<leader>sn', function()
			-- 	builtin.find_files { cwd = vim.fn.stdpath 'config' }
			-- end, { desc = '[S]earch [N]eovim files' })
		end,
	},

	-- UI:
	-- LUALINE:
	{'nvim-lualine/lualine.nvim', opts = { -- status line
		options = {
			theme = 'powerline_dark', -- gruvbox
			component_separators = { left = '', right = ''},
			section_separators   = { left = '', right = ''},
			always_divide_middle = false,
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'filename' },
			lualine_c = { 'branch', 'diff' },
			lualine_x = {
				{'encoding',
					fmt = function(str) if str == 'utf-8' then return '' else return str end end,
				},
				{'fileformat',
					symbols = {
						unix = '',  -- e712 - 
						dos  = '', -- e70f
						mac  = '', -- e711
					},
				},
				--'filetype',
			},
			lualine_y = {
				{'diagnostics',
					--sources = { 'nvim_diagnostic' },
					sections = { 'error', 'warn', 'info', 'hint' },
					diagnostics_color = {
						error = 'DiagnosticError',
						warn  = 'DiagnosticWarn',
						info  = 'DiagnosticInfo',
						hint  = 'DiagnosticHint',
					},
					symbols = {
						error = '󰅚 ', -- 󰅙
						warn  = ' ', -- 
						info  = ' ', -- 
						hint  = ' ', --  
					},
					update_in_insert = true,
					always_visible = false,   -- Show diagnostics even if there are none.
					colored = true,
				},
				{'selectioncount',
					format = {
						single_line_no_multibyte = '%c',
						single_line_multibyte = '%c-%b',
						multi_line_no_multibyte = '%c / %l',
						multi_line_multibyte = '%c-%b / %l',
						visual_block_mode = '%cx%l',
					},
				},
				{'searchcount',
					maxcount = 99999,
				},
			},
			lualine_z = {
				function()
					local line = vim.fn.line('.')
					local lines_total = vim.fn.line('$')
					local col = vim.fn.virtcol('.') -- TODO: change to normal col: to correctly count tabs?
					return string.format('Line: %d/%d, Col: %d', line, lines_total, col)
				end
			},
		},
	}},
	{'preservim/nerdtree', -- file manager
		init = function ()
			vim.g.NERDTreeSortOrder = { '[[extension]]' } -- TODO: change?
			vim.g.NERDTreeNaturalSort = 1
			vim.g.NERDTreeIgnore = {
				'\\.bin$',
				'\\.gif$',
				'\\.jpeg$',
				'\\.jpg$',
				'\\.png$',
				'\\.rar$',
				'\\.webp$',
				'\\.zip$',
			}
			keymap_n_cmd('<leader>n', 'NERDTreeToggle')
			keymap_n_cmd('<leader>Nf', 'NERDTreeFind')
		end
	},
	--'Xuyuanp/scrollbar.nvim', -- scrollbar

	-- TREESITTER:
	{'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
			'nvim-treesitter/playground',
		},
		init = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = {
					'c', 'lua', 'vim', 'vimdoc', 'query', -- these are reqired
					'comment',
					--'cpp',
					--'kotlin',
					--'latex',
					'nix',
					'python',
					'ron', -- Rust Object Notation
					'rust',
					'wgsl',
					--'yaml',
					--'yuck',
				},
				highlight = {
					enable = true,
					disable = function(lang, bufnr)
						return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 99999
					end,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				--indent = { enable = false, disable = { 'python', 'css' } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<c-space>',
						node_incremental = '<c-space>',
						scope_incremental = '<c-s>',
						node_decremental = '<c-backspace>',
					},
				},
				textobjects = { -- `nvim-treesitter-textobjects` required for this
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							['aa'] = '@parameter.outer', -- a = Argument
							['ia'] = '@parameter.inner', -- a = Argument
							--['ab'] = '@block.outer',
							--['ib'] = '@block.inner',
							['ac'] = '@class.outer',
							['ic'] = '@class.inner',
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							--ap   -- reserved for paragraph
							--ip   -- reserved for paragraph
							['ar'] = '@return.outer',
							['ir'] = '@return.inner',
							['as'] = '@assignment.outer', -- s = aSSignment
							['is'] = '@assignment.rhs',   -- s = aSSignment
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- set jumps in jumplist
						-- TODO: swap prev & next to confuse % motion less
						goto_next_start = {
							[']]'] = '@block.inner',
							[']a'] = '@parameter.rhs',
							[']b'] = '@block.inner',
							[']c'] = '@class.outer',
							[']f'] = '@function.outer',
							[']m'] = '@scopename.inner', -- TODO: test, maybe change
							--]p   -- reserved for paragraph
							[']r'] = '@return.inner',
							--[']s'] = '@assignment.rhs', -- TODO: resolve conflict/overlap with next spelling
						},
						goto_previous_start = {
							['[['] = '@block.inner',
							['[a'] = '@parameter.rhs',
							['[b'] = '@block.inner',
							['[c'] = '@class.outer',
							['[f'] = '@function.outer',
							['[m'] = '@scopename.inner', -- TODO: test, maybe change
							--[p   -- reserved for paragraph
							['[r'] = '@return.inner',
							--['[s'] = '@assignment.rhs', -- TODO: resolve conflict/overlap with next spelling
						},
						goto_next_end = {
							--[']}'] = todo,
							[']A'] = '@parameter.rhs',
							[']B'] = '@block.inner',
							[']C'] = '@class.outer',
							[']F'] = '@function.outer',
							[']M'] = '@scopename.inner', -- TODO: test, maybe change
							--[']P'] = '@parameter.inner',
							[']R'] = '@return.inner',
							[']S'] = '@assignment.rhs',
							[']['] = '@block.inner',
						},
						goto_previous_end = {
							--['[{'] = todo,
							['[A'] = '@parameter.rhs',
							['[B'] = '@block.inner',
							['[C'] = '@class.outer',
							['[F'] = '@function.outer',
							['[M'] = '@scopename.inner', -- TODO: test, maybe change
							--['[P'] = '@parameter.inner',
							['[R'] = '@return.inner',
							['[S'] = '@assignment.rhs',
							['[]'] = '@block.inner',
						},
					},
					swap = {
						enable = true,
						swap_next = {
							['>a'] = '@parameter.inner',
							-->p   -- reserved for paragraph
						},
						swap_previous = {
							['<a'] = '@parameter.inner',
							--<p   -- reserved for paragraph
						},
					},
				},
				--matchup = { -- for treesitter based % motion?, maybe related: https://github.com/nvim-treesitter/nvim-treesitter/issues/2769
				--	enable = true,
				--},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = 'o',
						toggle_hl_groups = 'i',
						toggle_injected_languages = 't',
						toggle_anonymous_nodes = 'a',
						toggle_language_display = 'I',
						focus_language = 'f',
						unfocus_language = 'F',
						update = 'R',
						goto_node = '<cr>',
						show_help = '?',
					},
				},
			}
		end,
	},

	-- LSP PLUGINS:
	{'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'saadparwaiz1/cmp_luasnip', -- for lua-snips
			--'hrsh7th/cmp-nvim-lua', -- #e1a547
		},
		-- opts = {
		-- 	inlay_hint = { enabled = true },
		-- },
		init = function()
			local lsp_server_names = {
				-- src: `:help lspconfig-all`
				'rust_analyzer', -- TODO: enable `clippy`?
				'pyright', -- python
				--'ruff_lsp', -- python linter -- TODO: setup
				'lua_ls',
				--'clangd', -- c/c++
				--'nil_ls', -- nix
				--'hls', -- haskell
			}
			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			for _, lsp_server_name in pairs(lsp_server_names) do
				-- print('LSP: setting up', lsp_server_name)
				require('lspconfig')[lsp_server_name].setup {
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						-- TODO: try when nvim 0.10
						-- print('Inlay hints: trying to attach')
						--if client.server_capabilities.inlayHintProvider then
						--	--inlay_hints.on_attach(client, bufnr)
						--	vim.lsp.inlay_hint.enable(bufnr, true)
						--	-- print('Inlay hints attached')
						--else
						--	-- print('Inlay hints NOT attached')
						--end
						-- print('Inlay hints: end')
					end
				}
			end

			vim.keymap.del('n', 'gri')
			vim.keymap.del('n', 'grr')
			vim.keymap.del({'n', 'x'}, 'gra')
			vim.keymap.del('n', 'grn')

			local telescope_builtin = require('telescope.builtin')

			keymap_n('gd', telescope_builtin.lsp_definitions)
			keymap_n('gD', vim.lsp.buf.declaration)
			keymap_n('gi', telescope_builtin.lsp_implementations)
			keymap_n('gr', telescope_builtin.lsp_references)
			keymap_n('<leader>r', vim.lsp.buf.rename)

			keymap_n('<c-h>', vim.diagnostic.goto_prev)
			keymap_n('<c-l>', vim.diagnostic.goto_next)

			keymap_n('ga', vim.lsp.buf.code_action)
			keymap_n('K', vim.lsp.buf.hover)

			keymap_n('go', telescope_builtin.lsp_document_symbols)
			keymap_n('gO', telescope_builtin.lsp_dynamic_workspace_symbols)

			keymap_n('gt', telescope_builtin.lsp_type_definitions)

			-- TODO:
			-- vim.lsp.buf.type_definition
			-- vim.lsp.buf.rename
			-- ? function() vim.lsp.buf.format { async = true } end

			-- enable this to print debug info to ~/.cache/nvim/lsp.log
			--vim.lsp.set_log_level('debug')

			vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics, {
					-- delay update diagnostics
					update_in_insert = true,
				}
			)

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config {
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				} or {},
				virtual_text = {
					source = 'if_many',
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			}
			keymap_n({'<leader>d', '<leader>в'}, vim.diagnostic.open_float)

			local cmp = require('cmp')
			cmp.setup {
				snippet = {
					-- REQUIRED - you MUST specify a snippet engine
					expand = function(args)
						--vim.fn['UltiSnips#Anon'](args.body)         -- for `ultisnips` users
						--vim.fn['vsnip#anonymous'](args.body)        -- for `vsnip` users
						--require('snippy').expand_snippet(args.body)   -- for `snippy` users
						require('luasnip').lsp_expand(args.body)        -- for `luasnip` users
					end,
				},
				window = {
					--completion = cmp.config.window.bordered(),
					--documentation = cmp.config.window.bordered(),
				},
				indent = { -- indentation based on treesitter for the `=` operator.
					enable = true,
				},
				-- experimental = {
				-- 	ghost_text = true,
				-- },
				sources = {
					{ name = 'nvim_lsp' },
					--{ name = 'nvim_lsp_signature_help' }, -- TODO: try it (from https://github.com/hrsh7th/nvim-cmp/wiki/Language-Server-Specific-Samples)
					-- TODO: dont ignore `\` & `'` in latex
					{ name = 'buffer', option = { keyword_pattern = [[\Z\k\+]] }},
					-- \Z\k\+
					-- м'ясо пом'якшити
					-- telescope
					-- test test test tmp123
					{ name = 'path' },
					--{ name = 'ultisnips' }, -- for ultisnips users
					--{ name = 'vsnip' },     -- for vsnip users
					--{ name = 'snippy' },    -- for snippy users
					{ name = 'luasnip' },     -- for luasnip users
					--{ name = 'nvim_lua', option = { include_deprecated = true } }, -- #e1a547
				},
				preselect = cmp.PreselectMode.Item,
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						-- cmp.config.compare.scopes,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						--require('cmp-under-comparator').under,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						-- cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				-- matching = {
				-- 	disallow_fuzzy_matching = true,
				-- 	disallow_fullfuzzy_matching = true,
				-- 	disallow_partial_fuzzy_matching = true,
				-- 	disallow_partial_matching = false,
				-- 	disallow_prefix_unmatching = true,
				-- },
				mapping = {
					['<cr>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					['<tab>'] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					['<s-tab>'] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
					['<A-space>'] = cmp.mapping.complete(),
					['<C-space>'] = cmp.mapping.complete(),
					--['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
					--['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
					--['<C-y>'] = cmp.config.disable, -- specify `cmp.config.disable` if you want to remove default `<C-y>` mapping
					--['<C-e>'] = cmp.mapping.abort(),
				},
			}

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
				}, {
					{ name = 'buffer' },
				}),
			})

			-- Use buffer source for `/` & `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' },
				}, {
					{ name = 'cmdline' },
				}),
			})
		end
	},

	-- {'nvim-tree/nvim-web-devicons', -- ?
	-- 	lazy = true,
	-- },

	{'Julian/lean.nvim',
		event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-lua/plenary.nvim',
			-- you also will likely want nvim-cmp or some completion engine
			'hrsh7th/nvim-cmp',
		},
		-- see details below for full configuration options
		opts = {
			lsp = {},
			mappings = true,
		}
	},

}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		-- TODO:
		icons = vim.g.have_nerd_font and {} or {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
})





-- TODO: load by lazy?
-- require 'dmytruek.blockmarks'



-- TODO: move these somewhere above?

-- vim.cmd([[
-- highlight MyTodo guifg=black guibg=orange
-- au VimEnter * syntax match MyTodo /TODO/
-- ]])

