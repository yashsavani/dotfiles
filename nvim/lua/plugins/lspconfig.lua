--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnum, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnum, ...) end
--   local noremap_silent = { noremap = true, silent = true }

--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

--   -- Mappings
--   buf_set_keymap("n", "gD", [[:lua vim.lsp.buf.declaration()<CR>]], noremap_silent)
--   buf_set_keymap("n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], noremap_silent)
--   buf_set_keymap("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]], noremap_silent)
--   buf_set_keymap("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]], noremap_silent)
--   -- buf_set_keymap("n", "<C-k>", [[<md>lua vim.lsp.buf.signature_help()<CR>]], noremap_silent)
--   -- buf_set_keymap("n", "<Leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], noremap_silent)
--   buf_set_keymap("n", "<Leader>wa", [[<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]], noremap_silent)
--   buf_set_keymap("n", "<Leader>wr", [[<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]], noremap_silent)
--   buf_set_keymap("n", "<Leader>wl", [[<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]], noremap_silent)
--   -- buf_set_keymap("n", "<Leader>D", [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], noremap_silent)
--   -- buf_set_keymap("n", "<Leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]], noremap_silent)
--   -- buf_set_keymap("n", "<Leader>e", [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], noremap_silent)
--   buf_set_keymap("n", "[d", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], noremap_silent)
--   buf_set_keymap("n", "]d", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], noremap_silent)
--   -- buf_set_keymap("n", "<Leader>q", [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]], noremap_silent)
--   -- buf_set_keymap("n", "<Leader>l", [[<cmd>lua require'lsp-codelens'.buf_codelens_action()<CR>]], noremap_silent)
--   vim.cmd [[command! Format execute 'lua vim.lsp.buf.formatting()']]

--   -- vim already has builtin docs
--   if vim.bo.ft ~= "vim" then buf_set_keymap("n", "K", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], noremap_silent) end

--   -- Set autocommands conditional on server_capabilities
--   if client.resolved_capabilities.document_highlight then
--     vim.api.nvim_exec([[
--     augroup lsp_document_highlight
--       autocmd! * <buffer>
--       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--     augroup END
--     ]], false)
--   end

--   if client.resolved_capabilities.code_lens then
--     vim.cmd [[
--     augroup lsp_codelens
--       autocmd! * <buffer>
--       autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua require"lsp-codelens".buf_codelens_refresh()
--     augroup END
--     ]]
--   end

--   if client.server_capabilities.colorProvider then
--     require"lsp-documentcolors".buf_attach(bufnum, { single_column = true })
--   end

--   -- vim already has builtin docs
--   if vim.bo.ft ~= "vim" then
--     buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", noremap_silent)
--   end
-- end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()


local texlab_settings = {
    texlab = {
        build = {
            onSave = true,
            forwardSearchAfter = false
        },
        forwardSearch = {
            executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
            args = { "%l", "%p", "%f" }
        }
    }
}

local lsp_installer = require("nvim-lsp-installer")
local servers = {
    "sumneko_lua",
    "pyright",
    "ltex",
}
for _, name in pairs(servers) do
    local ok, server = lsp_installer.get_server(name)
    -- Check that the server is supported in nvim-lsp-installer
    if ok then
        if not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
end

-- Provide settings first!
lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

-- lsp_installer.on_server_ready(function(server)
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities.textDocument.completion.completionItem.snippetSupport = true
--     capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
--     local opts = {
--         -- on_attach = on_attach,
--         capabilities = capabilities
--     }
--     if server.name == "ltex" then
--         -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
--         server:setup(opts)
--         vim.cmd [[ do User LspAttachBuffers ]]
--     end
-- end)

local install_root_dir = vim.fn.stdpath 'data' .. '/lsp_servers'

require "navigator".setup({
    default_mapping = false,
    keymaps = {
        { key = 'gr', func = "require('navigator.reference').reference()" },
        -- { key = 'Gr', func = "require('navigator.reference').async_ref()" },
        { mode = 'i', key = '<M-k>', func = 'signature_help()' },
        { key = '<c-k>', func = 'signature_help()' },
        { key = 'g0', func = "require('navigator.symbols').document_symbols()" },
        { key = 'gW', func = "require('navigator.workspace').workspace_symbol()" },
        { key = '<c-]>', func = "require('navigator.definition').definition()" },
        { key = 'gD', func = "declaration({ border = 'rounded', max_width = 80 })" },
        { key = 'gp', func = "require('navigator.definition').definition_preview()" },
        { key = '<Leader>gt', func = "require('navigator.treesitter').buf_ts()" },
        { key = '<Leader>gT', func = "require('navigator.treesitter').bufs_ts()" },
        { key = 'K', func = 'hover({ popup_opts = { border = single, max_width = 80 }})' },
        { key = '<Space>ca', mode = 'n', func = "require('navigator.codeAction').code_action()" },
        { key = '<Space>cA', mode = 'v', func = 'range_code_action()' },
        -- { key = '<Leader>re', func = 'rename()' },
        { key = '<Space>rn', func = "require('navigator.rename').rename()" },
        { key = '<Leader>gi', func = 'incoming_calls()' },
        { key = '<Leader>go', func = 'outgoing_calls()' },
        { key = 'gi', func = 'implementation()' },
        { key = '<Space>D', func = 'type_definition()' },
        { key = 'gL', func = "require('navigator.diagnostics').show_diagnostics()" },
        { key = 'gG', func = "require('navigator.diagnostics').show_buf_diagnostics()" },
        { key = '<Leader>dt', func = "require('navigator.diagnostics').toggle_diagnostics()" },
        { key = ']d', func = "diagnostic.goto_next({ border = 'rounded', max_width = 80})" },
        { key = '[d', func = "diagnostic.goto_prev({ border = 'rounded', max_width = 80})" },
        { key = ']r', func = "require('navigator.treesitter').goto_next_usage()" },
        { key = '[r', func = "require('navigator.treesitter').goto_previous_usage()" },
        { key = '<C-LeftMouse>', func = 'definition()' },
        { key = 'g<LeftMouse>', func = 'implementation()' },
        { key = '<Leader>k', func = "require('navigator.dochighlight').hi_symbol()" },
        { key = '<Space>wa', func = "require('navigator.workspace').add_workspace_folder()" },
        { key = '<Space>wr', func = "require('navigator.workspace').remove_workspace_folder()" },
        { key = '<Space>ff', func = 'formatting()', mode = 'n' },
        { key = '<Space>ff', func = 'range_formatting()', mode = 'v' },
        { key = '<Space>wl', func = "require('navigator.workspace').list_workspace_folders()" },
        { key = '<Space>la', mode = 'n', func = "require('navigator.codelens').run_action()" },
    },
    lsp_installer = true,
    -- lsp = {
    --     servers = { 'ltex' },
    --     pyright = { cmd = { install_root_dir .. '/python/node_modules/pyright/langserver.index.js', '--stdio' } },
    --     sumneko_lua = { cmd = { install_root_dir .. '/sumneko_lua/extension/server/bin/lua-language-server' } },
    --     -- texlab = { cmd = { install_root_dir .. '/latex/texlab' }, settings = texlab_settings },
    --     ltex = { cmd = { install_root_dir .. '/ltex/ltex-ls/bin/ltex-ls' } }
    -- }
})
