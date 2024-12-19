local nvim_lsp = require('lspconfig')

-- First find the root directory
local root_dir = require('jdtls.setup').find_root({ '.bemol', '.git' })
local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory' })[1]
local ws_folders_lsp = {}
if not bemol_dir then
	vim.notify(".bemol directory not found! Not in a Brazil workspace?", vim.log.levels.WARN)
else
	vim.notify(".bemol directory found: " .. bemol_dir, vim.log.levels.INFO)
	local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
	if file then
		for line in file:lines() do
			table.insert(ws_folders_lsp, line)
		end
		file:close()
	end
end
-- Java LSP configuration
nvim_lsp.jdtls.setup({
	-- Server configuration
	-- root_dir = require('jdtls.setup').find_root({ '.bemol' }),
	init_options = {
		workspaceFolders = ws_folders_lsp
	},
	cmd = {
		'jdtls', -- assuming jdtls is in your PATH
		'-data', vim.fn.expand('~/.cache/jdtls-workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')),
		'--jvm-arg=-XX:+UseParallelGC',
		'--jvm-arg=-XX:GCTimeRatio=4',
		'--jvm-arg=-XX:AdaptiveSizePolicyWeight=90',
		'--jvm-arg=-Dsun.zip.disableMemoryMapping=true',
		'--jvm-arg=-Xmx4G',
		'--jvm-arg=-Xms100m',
	},
	-- Important: Use the Brazil workspace root
	root_dir = function()
		return vim.fn.system('brazil-path'):gsub("%s+", "")
	end,
	-- Language server settings
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = 'fernflower' },
			completion = {
				favoriteStaticMembers = {
					"org.junit.Assert.*",
					"org.junit.Assume.*",
					"org.junit.jupiter.api.Assertions.*",
					"org.junit.jupiter.api.Assumptions.*",
					"org.junit.jupiter.api.DynamicContainer.*",
					"org.junit.jupiter.api.DynamicTest.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse"
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template =
					"${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
				},
				useBlocks = true,
			},
			project = {
				referencedLibraries = {
					"/Volumes/brazil-pkg-cache/**/*.jar",
					"**/build/generated-src/**",
					"**/build/lib/**/*.jar"
				}
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all"
				}
			},
			navigateToDecompiledSources = true,
			configuration = {
				maven = { downloadSources = true },
				updateBuildConfiguration = "automatic",
				sourcePaths = ws_folders_lsp, -- Add workspace folders as source paths
				runtimes = {
					{
						name = "JavaSE-17",
						path =
						"/Library/Java/JavaVirtualMachines/amazon-corretto-17.jdk/Contents/Home",
					},
					{
						name = "JavaSE-11",
						path =
						"/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home",
					},
				}
			},
		}
	},

	-- LSP Capabilities
	capabilities = require('cmp_nvim_lsp').default_capabilities(),

	on_attach = function(_, bufnr)
		local nmap = function(keys, func, desc)
			if desc then
				desc = "LSP: " .. desc
			end

			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end

		nmap("<leader>lr", vim.lsp.buf.rename, "[R]e[n]ame")
		nmap("<leader>ca", function()
			vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
		end, "[C]ode [A]ction")

		nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- See `:help K` for why this keymap
		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		nmap("<C-;>", vim.lsp.buf.signature_help, "Signature Documentation")

		-- Lesser used LSP functionality
		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")

		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end
})


-- require("mason-lspconfig").setup({
-- 	handlers = {
-- 		function(server_name)
-- 			local server = servers[server_name] or {}
-- 			require("lspconfig")[server_name].setup({
-- 				cmd = server.cmd,
-- 				settings = server.settings,
-- 				filetypes = server.filetypes,
-- 				capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
-- 			})
-- 		end,
-- 		jdtls = function()
-- 			require("lspconfig").jdtls.setup({
-- 				on_attach = function()
-- 					local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })
-- 					    [1]
-- 					local ws_folders_lsp = {}
-- 					if bemol_dir then
-- 						local file = io.open(bemol_dir .. "/ws_root_folders", "r")
-- 						if file then
-- 							for line in file:lines() do
-- 								table.insert(ws_folders_lsp, line)
-- 							end
-- 							file:close()
-- 						end
-- 					end
-- 					for _, line in ipairs(ws_folders_lsp) do
-- 						vim.lsp.buf.add_workspace_folder(line)
-- 					end
-- 				end,
-- 				cmd = {
-- 					"jdtls",
-- 					"--jvm-arg=-javaagent:" ..
-- 					require("mason-registry").get_package("jdtls"):get_install_path() ..
-- 					"/lombok.jar",
-- 				},
-- 			})
-- 		end,
-- 	},
-- })
