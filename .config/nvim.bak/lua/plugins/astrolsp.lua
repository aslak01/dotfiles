---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      -- autoformat = true, -- enable or disable auto formatting on start
      -- codelens = true, -- enable/disable codelens refresh on start
      -- inlay_hints = false, -- enable/disable inlay hints on start
      -- semantic_tokens = true, -- enable/disable semantic token highlighting
      signature_help = true,
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      no_insert_inlay_hints = {
        cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
        {
          event = "InsertEnter",
          desc = "disable inlay hints on insert",
          callback = function(args)
            local filter = { bufnr = args.buf }
            if vim.lsp.inlay_hint.is_enabled(filter) then
              vim.lsp.inlay_hint.enable(false, filter)
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = args.buf,
                once = true,
                callback = function() vim.lsp.inlay_hint.enable(true, filter) end,
              })
            end
          end,
        },
      },
      -- customize language server configuration options passed to `lspconfig`
      ---@diagnostic disable: missing-fields
      config = {
        gopls = {
          settings = {
            gopls = {
              codelenses = {
                generate = true, -- show the `go generate` lens.
                gc_details = true, -- Show a code lens toggling the display of gc's choices.
                test = true,
                tidy = true,
                vendor = true,
                regenerate_cgo = true,
                upgrade_dependency = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              semanticTokens = true,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = { hint = { enable = true, arrayIndex = "Disable" } },
          },
        },
        markdown_oxide = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = { dynamicRegistration = true },
            },
          },
        },
        typos_lsp = { single_file_support = false },
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = { enabled = "always" },
            },
            javascript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = { enabled = "always" },
            },
          },
        },
      },
    },
  },
}
--     -- lsp_document_highlight = {
--     --   -- Optional condition to create/delete auto command group
--     --   -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
--     --   -- condition will be resolved for each client on each execution and if it ever fails for all clients,
--     --   -- the auto commands will be deleted for that buffer
--     --   cond = "textDocument/documentHighlight",
--     --   -- cond = function(client, bufnr) return client.name == "lua_ls" end,
--     --   -- list of auto commands to set
--     --   {
--     --     -- events to trigger
--     --     event = { "CursorHold", "CursorHoldI" },
--     --     -- the rest of the autocmd options (:h nvim_create_autocmd)
--     --     desc = "Document Highlighting",
--     --     callback = function() vim.lsp.buf.document_highlight() end,
--     --   },
--     --   {
--     --     event = { "CursorMoved", "CursorMovedI", "BufLeave" },
--     --     desc = "Document Highlighting Clear",
--     --     callback = function() vim.lsp.buf.clear_references() end,
--     --   },
--     -- },
--   },
--   -- customize lsp formatting options
--   formatting = {
--     -- control auto formatting on save
--     format_on_save = {
--       enabled = true, -- enable or disable format on save globally
--       allow_filetypes = { -- enable format on save for specified filetypes only
--         -- "go",
--       },
--       ignore_filetypes = { -- disable format on save for specified filetypes
--         -- "python",
--       },
--     },
--     disabled = { -- disable formatting capabilities for the listed language servers
--       -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
--       -- "lua_ls",
--     },
--     timeout_ms = 1000, -- default format timeout
--     -- filter = function(client) -- fully override the default formatting function
--     --   return true
--     -- end
--   },
--   -- enable servers that you already have installed without mason
--   servers = {
--     -- "pyright"
--   },
--   handlers = {
--     -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
--     -- function(server, opts) require("lspconfig")[server].setup(opts) end
--
--     -- the key is the server that is being setup with `lspconfig`
--     -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
--     -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
--   },
--   -- mappings to be set up on attaching of a language server
--   mappings = {
--     i = {},
--     n = {
--       gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
--       -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
--       -- gD = {
--       --   function() vim.lsp.buf.declaration() end,
--       --   desc = "Declaration of current symbol",
--       --   cond = "textDocument/declaration",
--       -- },
--       -- ["<Leader>uY"] = {
--       --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
--       --   desc = "Toggle LSP semantic highlight (buffer)",
--       --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
--       -- },
--     },
--   },
--   -- A custom `on_attach` function to be run after the default `on_attach` function
--   -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
--   on_attach = function(client, bufnr)
--     -- this would disable semanticTokensProvider for all clients
--     -- client.server_capabilities.semanticTokensProvider = nil
--   end,
