return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- Force Neovim to recognize .v and .sv files correctly for verible
            vim.filetype.add({
                extension = {
                    v = "verilog",
                    sv = "systemverilog",
                    svh = "systemverilog",
                },
            })

            local servers = {
                "lua_ls",
                "clangd",
                "zls",
                "ocamllsp",
                "pyright",
                "hls",
                "verible",
            }

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if
                        client
                        and client.supports_method(vim.lsp.protocol.Methods.textDocument_semanticTokens_full, nil)
                    then
                        vim.lsp.semantic_tokens.start(event.buf, client.id)
                    end
                end,
            })

            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                local map = function(keys, func, desc)
                    desc = { desc = "LSP: " .. desc }
                    local newOpts = vim.tbl_extend("force", opts, desc)
                    vim.keymap.set("n", keys, func, newOpts)
                end

                map("gr", vim.lsp.buf.references, "Go to References")
                map("gd", vim.lsp.buf.definition, "Go to Definition")
                map("K", vim.lsp.buf.hover, "Hover")
                map("gD", vim.lsp.buf.declaration, "Go to Declaration")
                map("gi", vim.lsp.buf.implementation, "Go to Implementation")
                map("<leader>lf", vim.lsp.buf.format, "Format language")
                map("<leader>lr", vim.lsp.buf.rename, "Rename")
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Modern native API setup for lua_ls
            vim.lsp.config("lua_ls", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- Setup remaining servers dynamically
            for _, server_name in ipairs(servers) do
                if server_name ~= "lua_ls" then
                    local server_config = {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }

                    -- Explicitly define command and filetypes for verible 
                    if server_name == "verible" then
                        server_config.cmd = { "verible-verilog-ls" }
                        server_config.filetypes = { "verilog", "systemverilog" }
                    end

                    vim.lsp.config(server_name, server_config)
                    vim.lsp.enable(server_name)
                end
            end

            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    ["<C-space>"] = cmp.mapping.complete({}),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }),
            })
        end,
    },
}
