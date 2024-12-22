local plugins = {
	{
		"stevearc/conform.nvim",
		opts = require("configs.conform"),
	},
	{
		"echasnovski/mini.files",
		version = false,
		lazy = false,
		config = function()
			require("mini.files").setup({
				mappings = {
					go_in_plus = "l",
					go_out_plus = "h",
				},
				options = {
					use_as_default_explorer = false,
				},
				windows = {
					preview = true,
				},
			})
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
		},
		config = function()
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup({
				-- your neotest config here
				adapters = {
					require("neotest-go"),
				},
			})
		end,
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
		lazy = false,
	},
	{
		"itchyny/vim-cursorword",
		lazy = false,
	},
	{
		"romainl/vim-cool",
		lazy = false,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		lazy = false,
		config = function()
			local id = require("mini.indentscope")
			id.setup({
				draw = {
					delay = 10,
					animation = id.gen_animation.cubic({ duration = 100, unit = "total" }),
				},
				symbol = "│",
			})
		end,
	},
	{
		"echasnovski/mini.animate",
		version = false,
		lazy = false,
		config = function()
			local animate = require("mini.animate")
			animate.setup({
				cursor = {
					timing = animate.gen_timing.cubic({ duration = 125, unit = "total" }),
				},
				scroll = {
					enable = false,
				},
			})
		end,
	},
	{
		"b0o/incline.nvim",
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					return {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						" ",
						guibg = "#44406e",
					}
				end,
			})
		end,
		-- Optional: Lazy load Incline
		event = "VeryLazy",
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
				-- {
				theme = "hyper",
				config = {
					header = {
						"=================     ===============     ===============   ========  ========",
						"\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
						"||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
						"|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
						"||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
						"|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
						"||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
						"|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
						"||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
						"||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
						"||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
						"||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
						"||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
						"||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
						"||   .=='    _-'          '-__\\._-'         '-_./__-'         `' |. /|  |   ||",
						"||.=='    _-'                                                     `' |  /==.||",
						"==    _-'                        N E O V I M                         \\/   `==",
						"\\   _-'                                                                `-_   /",
						" `''                                                                      ``'",
					},
					-- week_header = {
					--    enable = true,
					-- },
					shortcut = {
						{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Apps",
							group = "DiagnosticHint",
							action = "Telescope app",
							key = "a",
						},
						{
							desc = " dotfiles",
							group = "Number",
							action = "Telescope dotfiles",
							key = "d",
						},
					},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		opts = {
			extensions_list = {
				"themes",
				"terms",
				"fzf",
				"live_grep_args",
			},
			extensions = {
				live_grep_args = {
					auto_quoting = true,
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"github/copilot.vim",
		lazy = false,
		config = function()
			-- Mapping tab is already used by NvChad
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_tab_fallback = ""
			-- The mapping is set to other key, see custom/lua/mappings
			-- or run <leader>ch to see copilot mapping section
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		lazy = false,
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},
	{
		"tpope/vim-surround",
		lazy = false,
	},
	{
		"fatih/vim-go",
		lazy = false,
	},
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("grapple").statusline()
		end,
		opts = {
			scope = "git_branch",
			icons = true,
		},
		keys = {
			{ "<leader>hh", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle tags menu" },
		},
	},
	{
		"folke/which-key.nvim",
		enabled = false,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
	},
	{
		"ggandor/leap.nvim",
		lazy = false,
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		--       experimental = {
		--          ghost_text = true,
		--       },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"go",
				"python",
				"tsx",
				"c",
				"markdown",
				"markdown_inline",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-a>",
					scope_incremental = "grc",
					node_incremental = "<C-a>",
					node_decremental = "<bs>",
				},
			},
			indent = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["a="] = "@assignment.outer",
						["i="] = "@assignment.inner",
						["at"] = "@comment.outer",
						["it"] = "@comment.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<Leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<Leader>A"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]a"] = { query = "@parameter.inner", desc = "Next function call start" },
						["]f"] = { query = "@call.outer", desc = "Next function call start" },
						["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]l"] = { query = "@loop.outer", desc = "Next loop start" },

						-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
						-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
						["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
					},
					goto_next_end = {
						["]A"] = { query = "@parameter.inner", desc = "Next function call start" },
						["]F"] = { query = "@call.outer", desc = "Next function call end" },
						["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[a"] = { query = "@parameter.inner", desc = "Next function call start" },
						["[f"] = { query = "@call.outer", desc = "Prev function call start" },
						["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
						["[c"] = { query = "@class.outer", desc = "Prev class start" },
						["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						["[A"] = { query = "@parameter.inner", desc = "Next function call start" },
						["[F"] = { query = "@call.outer", desc = "Prev function call end" },
						["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
						["[C"] = { query = "@class.outer", desc = "Prev class end" },
						["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
				lsp_interop = {
					enable = true,
				},
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				-- lua stuff
				"lua-language-server",
				"stylua",
				"luacheck",

				-- web dev stuff
				"css-lsp",
				"html-lsp",
				"typescript-language-server",
				"deno",
				"prettier",
				"prettierd",
				"shfmt",
				"terraform_fmt",

				-- c/cpp stuff
				"clangd",
				"clang-format",
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		lazy = true,
		opts = {
			git = {
				enable = true,
			},
			renderer = {
				highlight_git = true,
				icons = {
					show = {
						git = true,
					},
				},
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 250,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "\t<author>, <author_time:%Y-%m-%d> - <summary>",
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- For fun
	{
		"eandrju/cellular-automaton.nvim",
		lazy = false,
	},
	-- switch barbecue to dropbar later when upgrade to nvim 0.10
	-- {
	--    "Bekaboo/dropbar.nvim",
	--    -- optional, but required for fuzzy finder support
	--    config = function()
	--       require("dropbar").setup {
	--          general = {
	--             enable = true,
	--          },
	--       }
	--    end,
	--    dependencies = {
	--       "nvim-telescope/telescope-fzf-native.nvim",
	--    },
	--    lazy = false,
	-- },
	-- {
	--   "karb94/neoscroll.nvim",
	--   config = function()
	--     require("neoscroll").setup {
	--       mappings = { "zt", "zz", "zb" },
	--       easing_function = "cubic",
	--       pre_hook = function()
	--         vim.opt.eventignore:append {
	--           "WinScrolled",
	--           "CursorMoved",
	--         }
	--       end,
	--       post_hook = function()
	--         vim.opt.eventignore:remove {
	--           "WinScrolled",
	--           "CursorMoved",
	--         }
	--       end,
	--     }
	--   end,
	--   lazy = false,
	-- },
}
return plugins
