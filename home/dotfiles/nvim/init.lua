----- dmyTRUEk's NeoVim config file -----


function print_table(table)
	print(vim.inspect(table))
end


vim_globals = {
	python3_host_prog = '/usr/bin/python3',

	-- Set `mapleader` before `lazy` so that mappings are correct.
	mapleader = ' ',
}

for name, value in pairs(vim_globals) do
	-- TODO?: wrap in "try/catch"
	vim.g[name] = value
end


options_enable = {
	'number', 'relativenumber', -- line number + relative
	'cursorline', -- highlight cursor line
	-- 'cursorcolumn', -- highlight cursor column
	--'termguicolors', -- ?
	--'showmatch', -- shows matching brackets
	'autochdir', -- change current dir to file's dir (folder directory)
	--'showcmd', -- ? show last command (if you pressed 'j' then 'j' will be showed)

	--'incsearch',
	--'hlsearch',
	'ignorecase', -- /word will find 'word' or 'Word' or 'WORD'
	'smartcase', -- when 'ignorecase' & 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not; for example, '/The' would find only 'The', while '/the' would find both 'the' & 'The'

	--'noexpandtab',
	'list',

	'linebreak', -- wrap on words (wrap on chars in `breakat`)

	--'langremap', -- ?
}
-- TODO: move all "executers" (options etc setters) to the bottom/other file?
for _, name in pairs(options_enable) do
	-- TODO: wrap in "try/catch"
	vim.opt[name] = true
end

options_disable = {
	--'modeline', -- ?
}
-- TODO: move all "executers" (options etc setters) to the bottom/other file?
for _, name in pairs(options_disable) do
	-- TODO: wrap in "try/catch"
	vim.opt[name] = false
end



options = {
	--syntax = 'enable', -- ?
	clipboard = 'unnamedplus', -- use OS's clipboard
	encoding = 'utf-8',
	filetype = 'on',

	-- TODO: remove?
	laststatus = 2, -- when/how to display status-bar: 0=never, 1={if > than 2 windows}, 2=always
	virtualedit = 'block',
	scrolloff = 10, -- TODO: use relative

	-- TODO: smart detection of tabs or spaces are used in file
	tabstop = 4, -- size of tab used for "rendering"
	shiftwidth = 4, -- size of tab used for << >> etc
	listchars = {
		tab = '» ',
		trail = '·',
		nbsp = '␣',
	},

	--timeoutlen = 1000,
	--ttimeoutlen = 0,

	redrawtime = 10000, -- for giant files

	--cmdheight = 0, -- TODO: enable

	-- use ukr in normal mode
	--langmap = [[ʼ~,аf,б\,,вd,гu,дl,еt,є',ж\;,зp,иb,іs,ї],йq,кr,лk,мv,нy,оj,пg,рh,сc,тn,уe,фa,х[,цw,чx,шi,щo,ьm,ю.,яz,АF,Б<,ВD,ГU,ДL,ЕT,Є",Ж:,ЗP,ИB,ІS,Ї},ЙQ,КR,ЛK,МV,НY,ОJ,ПG,РH,СC,ТN,УE,ФA,Х{,ЦW,ЧX,ШI,ЩO,ЬM,Ю>,ЯZ]],
	langmap = [[йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\;,є',яz,чx,сc,мv,иb,тn,ьm,б\,,ю.,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Є",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>]],

	--mouse = 'a',
}
for name, value in pairs(options) do
	-- TODO: wrap in "try/catch"
	vim.opt[name] = value
end


-- TODO(refactor): append to vim globals?
vim.g.relative_scrolloff_percentage = 30
function set_relative_scrolloff(fraction)
	-- TODO
end



-- TODO: test if `x` or `v` is needed
keybinds_swap_nv = {
	['0'] = '^',
	["'"] = '`',
}

keybinds_nv = {
	['<c-j>'] = '<c-d>zz', -- better move half-page down
	['<c-k>'] = '<c-u>zz', -- better move half-page up

	['<c-n>'] = '%',

	-- ['<c-/>'] = 'gc', -- TODO
}

keybinds_n = {
	Q = '', -- unmap ex mode
	U = '<c-r>', -- better redo
	Y = 'y$', -- better copy till end of line

	['-'] = '$', -- better $

	['<c-p>'] = '$p', -- paste at end of line
	['<a-p>'] = '^P', -- paste at begin of line

	-- "fix" `h` & `l` motions:
	ch = 'lc2h',
	cl = 'c2l',
	dh = 'ld2h',
	dl = 'd2l',
	yh = 'ly2h',
	yl = 'y2l',

	-- "fix" `b` motion:
	-- cb = 'cb<DEL>', TODO

	-- `f` & `t` from end of line
	gf = '$F',
	gt = '$T',

	-- work with function names:
	cn = 'ct(',
	dn = 'dt(',
	yn = 'yt(',
	cu = 'ct_',
	du = 'df_',
	yu = 'yt_',

	['c;'] = 'ct;',
	['d;'] = 'dt;',
	['y;'] = 'yt;',

	['<leader>;'] = 'm`A;<esc>``',
	['<leader>:'] = 'm`A:<esc>``',
	['<leader>,'] = 'm`A,<esc>``',
	['<leader>.'] = 'm`A.<esc>``',

	--['<leader>e'] = 'm`$x``',

	-- TODO: make one more plugin?)
	-- my Change Current word with another (aka `viwy`):

	-- `cc` is duplication of `S`, so we can use it for our purposes, so firstly we clearing it
	cc = '',

	-- map `cc<move>` to Change Current word with MOVE word
	-- this solution is better than `df<space>f<space>p` because it might not work if
	-- there is no space after second word (eg `,` `)` `\n` etc)

	-- TODO?: figure out better way to do this, so it works at least for `f<symbol>` or even any move
	-- TODO: fix it for ukr

	-- here `|` means cursor position
	-- a|aa bbb -> bbb| aaa
	ccw = 'yiwwviwp2bviwp',
	-- aaa.a|aa bbb.bbb -> bbb.bbb| aaa.aaa
	ccW = 'yiWWviWp2BviWp',

	-- aaa b|bb -> bbb aaa|
	ccb = 'yiwbviwpwviwp',
	-- aaa.aaa bbb.b|bb -> bbb.bbb aaa.aaa|
	ccB = 'yiWBviWpWviWp',

	cc2w = 'yiw2wviwp3bviwp',
	cc2W = 'yiW2WviWp3BviWp',
	cc2b = 'yiw2bviwp2wviwp',
	cc2B = 'yiW2BviWp2WviWp',

	cc3w = 'yiw3wviwp4bviwp',
	cc3b = 'yiw3bviwp3wviwp',
	cc3W = 'yiW3WviWp4BviWp',
	cc3B = 'yiW3BviWp3WviWp',

	['<c-cr>'] = '<c-6>', -- goto to prev file(buffer?)

	['<esc>'] = '<cmd>nohlsearch<cr>',

	-- TODO?: add `zb` == `zw`: spelling bad/wrong

	['g/m'] = '/<<<<<<<\\|=======\\|>>>>>>><cr>',
}

keybinds_i = {
	['<c-;>'] = '',
	['<c-h>'] = '<left>',
	['<c-j>'] = '<down>',
	['<c-k>'] = '<up>',
	['<c-l>'] = '<right>',
}

keybinds_n_c = {
	-- DEPRECATED
	['<leader>o'] = 'nohlsearch',

	['<leader>q'] = 'q',
	['<leader>Q'] = 'qa',
	['<leader>w'] = 'w',
	['<leader>W'] = 'wa',
	['<leader>a'] = 'wq',
	['<leader>A'] = 'wqa',

	['<leader>h'] = 'wincmd h',
	['<leader>j'] = 'wincmd j',
	['<leader>k'] = 'wincmd k',
	['<leader>l'] = 'wincmd l',

	['<leader><leader>h'] = 'wincmd H',
	['<leader><leader>j'] = 'wincmd J',
	['<leader><leader>k'] = 'wincmd K',
	['<leader><leader>l'] = 'wincmd L',

	['<leader>S'] = 'setlocal spell!',

	--<leader>v :call ToggleHorizontalVerticalSplit() <cr>
}

-- TODO: test if `x` or `v` is needed
keybinds_v = {
	['-'] = '$h', -- better $
	S = ':sort<cr>',
}



autocmds = {
	{'FileType', {
		pattern = {
			'gitcommit',
			'markdown', -- .md
			'tex',
			'text', -- .txt
		},
		command = 'setlocal spell spelllang=uk,en'
	}},
	{{'BufEnter', 'BufLeave', 'BufWinEnter', 'BufWinLeave', 'WinNew', 'WinEnter', 'WinLeave', 'VimResized'}, {
		callback = function()
			--TODO:
			--set_relative_scrolloff()
		end
	}},
	{'FileType', {
		-- set tabs EVERYWHERE
		pattern = '*',
		callback = function()
			-- TODO: smart detection of tabs or spaces are used in file
			vim.opt_local.expandtab = false
			vim.opt_local.tabstop = options.tabstop
			vim.opt_local.shiftwidth = options.shiftwidth
			--vim.opt_local.softtabstop = options.softtabstop
			--vim.opt_local.smarttab = true
		end
	}},
	{'FileType', {
		pattern = "tex",
		callback = function()
			-- TODO: refactor
			require 'dmytruek.latex_autos'
			vim.cmd("call SetupEverythingForLatex()")
		end
	}},
	{'FileType', {
		pattern = 'text',
		callback = function()
			vim.keymap.set('n', 'j', 'gj')
			vim.keymap.set('n', 'k', 'gk')
		end
	}}
}





-- Load `lazy.nvim`:
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS:
require('lazy').setup {
	-- Colorschemes:
	--'ErichDonGubler/vim-sublime-monokai',
	--'nlknguyen/papercolor-theme',
	--'kjssad/quantum.vim',
	{'ellisonleao/gruvbox.nvim',
		init = function()
			require 'dmytruek.colorschemes.gruvbox'
		end
	},
	'rebelot/kanagawa.nvim',
	'catppuccin/nvim',
	--'projekt0n/github-nvim-theme',
	--'navarasu/onedark.nvim',
	'folke/tokyonight.nvim',

	-- Core:
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
			keybinds_n['ds'] = '<Plug>Dsurround'
			keybinds_n['ds'] = '<Plug>Dsurround'
			keybinds_n['cs'] = '<Plug>Csurround'
			keybinds_n['cS'] = '<Plug>CSurround'
			keybinds_n['ys'] = '<Plug>Ysurround'
			keybinds_n['yS'] = '<Plug>YSurround'
			keybinds_n['yss'] = '<Plug>Yssurround'
			keybinds_n['ySs'] = '<Plug>YSsurround'
			keybinds_n['ySS'] = '<Plug>YSsurround'
			keybinds_v['s']  = '<Plug>VSurround'
			keybinds_v['gs'] = '<Plug>VgSurround'
			local function set(scope, char, surround_expression)
				vim[scope]['surround_'..vim.fn.char2nr(char)] = surround_expression
			end
			local function set_global(char, surround_expression)
				set('g', char, surround_expression)
			end
			local function set_local(char, surround_expression)
				set('b', char, surround_expression)
			end
			autocmds[#autocmds+1] = {'FileType', {
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
			}}
			autocmds[#autocmds+1] = {'FileType', {
				pattern = 'markdown',
				callback = function()
					set_local('l', '[\r]()')
					set_local('L', '[](\r)')
				end
			}}
			autocmds[#autocmds+1] = {'FileType', {
				pattern = 'python',
				callback = function()
					set_local('I', 'Iterator[\r]')
					set_local('L', 'list[\r]')
					set_local('T', 'tuple[\r]')
					set_local('i', 'filter(\r)')
					set_local('l', 'list(\r)')
					set_local('m', 'map(\r)')
					set_local('r', 'range(\r)')
					set_local('t', '\1Type: \1[\r]')
				end
			}}
			autocmds[#autocmds+1] = {'FileType', {
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
			}}
			autocmds[#autocmds+1] = {'FileType', {
				pattern = 'tex',
				callback = function()
					set_local('l', '\\\1Name: \1{\r}')
					set_local('L', '\\begin{\1Environment: \1}\r\\end{\1\1}')
					set_local('b', '\\textbf{\r}')
					set_local('i', '\\textit{\r}')
					set_local('u', '\\underline{\r}')
					set_local('t', '\\text{\r}')
				end
			}}
			autocmds[#autocmds+1] = {'FileType', {
				pattern = 'lean',
				callback = function()
					set_local('c', '/-\r-/')
				end
			}}
			autocmds[#autocmds+1] = {'FileType', {
				pattern = 'html',
				callback = function()
					local function set_local_wrap_in_tag(key, tag)
						tag = tag or key -- default arg
						set_local(key, '<'..tag..'>\r</'..tag..'>')
					end
					set_local('c', '<!--\r-->')
					set_local_wrap_in_tag('p')
					set_local_wrap_in_tag('d', 'div')
					set_local_wrap_in_tag('h1')
					set_local_wrap_in_tag('h2')
					set_local_wrap_in_tag('h3')
					set_local_wrap_in_tag('h4')
					set_local_wrap_in_tag('h5')
					set_local_wrap_in_tag('h6')
				end
			}}
		end
	},
	{'tommcdo/vim-exchange', -- exchange selections
		init = function()
			keybinds_v['x'] = '<Plug>(Exchange)'
		end
	},
	'tpope/vim-repeat', -- enable repeat for plugins
	{'unblevable/quick-scope', -- better find in line
		init = function()
			-- TODO(refactor): append to vim globals?
			vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
		end
	},

	-- General:
	'tpope/vim-commentary', -- comments manager
	{'L3MON4D3/LuaSnip', -- snippets
		version = 'v2.*',
		-- opts = {},
		init = function()
			require('luasnip.loaders.from_snipmate').lazy_load()
			local ls = require 'luasnip'
			keybinds_i['<F8>'] = ls.expand
			keybinds_i['<F9>'] = ls.expand
			keybinds_i['<F10>'] = ls.expand
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

	-- UI:
	-- LUALINE:
	{'nvim-lualine/lualine.nvim', opts = { -- status line
		options = {
			theme = 'powerline_dark', -- gruvbox, kanagawa
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
	{'preservim/nerdtree',
		init = function ()
			vim.g.NERDTreeSortOrder = { '[[extension]]' }
			vim.g.NERDTreeNaturalSort = 1
			vim.g.NERDTreeIgnore = { '\\.bin$', '\\.png$', '\\.jpg$', '\\.jpeg$', '\\.gif$', '\\.webp$' }
			keybinds_n_c['<leader>n'] = 'NERDTreeToggle'
		end
	}, -- file manager
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
					--'yaml',
					--'yuck',
				},
				highlight = {
					enable = true,
					disable = function(lang, bufnr)
						--return vim.api.nvim_buf_line_count(bufnr) > 99999
						return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 999999
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

	-- TELESCOPE:
	{'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzf-native.nvim',
		},
		init = function()
			local keybinds_n_c_telescope = {
				['<leader>b'] = 'buffers',
				['<leader>f'] = 'find_files',
				['<leader>g'] = 'live_grep',
				['<leader>p'] = 'colorscheme',
				['<leader>s'] = 'spell_suggest',
				['<leader>u'] = 'jumplist',
				--gd = 'lsp_definitions',
				--gD = 'lsp_type_definitions',
				gi = 'lsp_implementations',
				gr = 'lsp_references',
			}
			for keybind, telescope_command in pairs(keybinds_n_c_telescope) do
				-- TODO: wrap in "try/catch"
				keybinds_n_c[keybind] = 'Telescope ' .. telescope_command
			end

			local actions = require('telescope.actions')
			require('telescope').setup {
				defaults = {
					mappings = {
						i = {
							['<esc>'] = actions.close,
						},
					},
				},
			}
		end,
	},

	-- LSP:
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
				'rust_analyzer', -- TODO: enable `clippy`
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

			keybinds_n['gd'] = vim.lsp.buf.definition
			keybinds_n['gD'] = vim.lsp.buf.declaration
			--keybinds_n['gi'] = vim.lsp.buf.implementations
			--keybinds_n['gr'] = vim.lsp.buf.references
			keybinds_n['<leader>r'] = vim.lsp.buf.rename
			keybinds_n['<leader>d'] = vim.diagnostic.open_float

			keybinds_n['g['] = vim.diagnostic.goto_prev
			keybinds_n['g]'] = vim.diagnostic.goto_next
			keybinds_n['<c-h>'] = vim.diagnostic.goto_prev
			keybinds_n['<c-l>'] = vim.diagnostic.goto_next

			keybinds_n['ga'] = vim.lsp.buf.code_action
			keybinds_n['K'] = vim.lsp.buf.hover

			vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics, {
					-- delay update diagnostics
					update_in_insert = true,
				}
			)

			-- TODO:
			-- vim.lsp.buf.type_definition
			-- vim.lsp.buf.rename
			-- ? function() vim.lsp.buf.format { async = true } end

			-- enable this to print debug info to ~/.cache/nvim/lsp.log
			--vim.lsp.set_log_level('debug')

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

	{
		'Julian/lean.nvim',
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
}





-- TODO(refactor): move to `colorschemes`?
vim.cmd.colorscheme('gruvbox')





-- TODO(refactor): unite/simplify?
keybind_set_n = function(keybind, action) vim.keymap.set('n', keybind, action) end
keybind_set_v = function(keybind, action) vim.keymap.set('v', keybind, action) end

keybind_swap_n = function(kb1, kb2) keybind_set_n(kb1, kb2); keybind_set_n(kb2, kb1) end
keybind_swap_v = function(kb1, kb2) keybind_set_v(kb1, kb2); keybind_set_v(kb2, kb1) end
keybind_swap_nv = function(kb1, kb2) keybind_swap_n(kb1, kb2); keybind_swap_v(kb1, kb2) end

-- TODO: test if `x` or `v` is needed
for kb1, kb2 in pairs(keybinds_swap_nv) do
	-- TODO: wrap in "try/catch"
	keybind_swap_nv(kb1, kb2)
end

for keybind, action in pairs(keybinds_nv) do
	-- TODO: wrap in "try/catch"
	vim.keymap.set('n', keybind, action)
	vim.keymap.set('v', keybind, action)
end

for keybind, action in pairs(keybinds_n) do
	-- TODO: wrap in "try/catch"
	vim.keymap.set('n', keybind, action)
end

for keybind, action in pairs(keybinds_i) do
	-- TODO: wrap in "try/catch"
	vim.keymap.set('i', keybind, action)
end

for keybind, command in pairs(keybinds_n_c) do
	-- TODO: wrap in "try/catch"
	--vim.keymap.set('n', keybind, ':' .. command .. '<cr>')
	vim.keymap.set('n', keybind, '<cmd>' .. command .. '<cr>')
end

for keybind, action in pairs(keybinds_v) do
	-- TODO: wrap in "try/catch"
	vim.keymap.set('v', keybind, action)
end

-- TODO: automatically support ukr layout


for _, autocmd in pairs(autocmds) do
	local events, opts = unpack(autocmd)
	--local events = autocmd[1]
	--local opts = autocmd[2]
	--print_table(events)
	--print_table(opts)
	-- TODO: wrap in "try/catch"
	vim.api.nvim_create_autocmd(events, opts)
end



-- TODO: load by lazy?
require 'dmytruek.blockmarks'



test_map = {
	a = 'abc',
	s = 'def',
	as = 'ghi',
	sa = 'jkl',
	['<leader>a'] = 'mno',
	['<leader>as'] = 'pqr',
	['<a-a>'] = 'stu',
	['<a-s>a'] = 'vw',
	['<a-as>dm'] = 'xyz',
}

function parse_keybind(keybind_str)
	-- abc -> {  }
	local keybind = {}
	local level = 0 -- triangle brackets level
	for i = 1, #keybind_str do
		local c = keybind_str:sub(i, i)
		-- print(i, c, level)
		if level < 0 or level > 1 then error('bad <> sequence') end
		if c == '<' then
			level = level + 1
		elseif c == '>' then
			level = level - 1
		else
			if level == 0 then
				keybind[#keybind+1] = c
			else
				-- TODO?
			end
		end
	end
	return keybind
end

function translate_keybind(keybind_str, translation)
	-- TODO: write own/custom keybind parser (into meaningful structure) and then rewrite this function using it?
	-- error('msg')
	print('\n')
	print('keybind_str =', '`'..keybind_str..'`')
	local keybind_translated = ''
	-- local keybind = parse_keybind(keybind_str)
	-- print_table(keybind)
	keybind_translated = keybind_str:gsub(
		-- '(<[cCaAsS](-[cCaAsS])*-)(.)(>)',
		'<([cCaAsS]-)(.)>',
		function (...)
			local args = { ... }
			local len = #args
			print('args =', args[1], args[len-1], args[len])
			local c = args[len-1]
			-- TODO: support uppercase
			return args[1] .. translation[c] .. '>'
		end
	)
	return keybind_translated
end

translation_eng_to_ukr = {
	q = 'й',
	w = 'ц',
	e = 'у',
	r = 'к',
	t = 'е',
	y = 'н',
	u = 'г',
	i = 'ш',
	o = 'щ',
	p = 'з',
	a = 'ф',
	s = 'і',
	d = 'в',
	f = 'а',
	g = 'п',
	h = 'р',
	j = 'о',
	k = 'л',
	l = 'д',
	z = 'я',
	x = 'ч',
	c = 'с',
	v = 'м',
	b = 'и',
	n = 'т',
	m = 'ь',
}

-- for keybind, action in pairs(test_map) do
-- 	print('`'..keybind..'`', '->' , '`'..translate_keybind(keybind, translation_eng_to_ukr)..'`')
-- end

vim.cmd([[
highlight MyTodo guifg=black guibg=orange
au VimEnter * syntax match MyTodo /TODO/
]])

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Flash highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('flash-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

