local on_attach = function(client, bufnum)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnum, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnum, ...) end
  local noremap_silent = { noremap = true, silent = true }

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  buf_set_keymap("n", "gD", [[:lua vim.lsp.buf.declaration()<CR>]], noremap_silent)
  buf_set_keymap("n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], noremap_silent)
  buf_set_keymap("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]], noremap_silent)
  buf_set_keymap("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<C-k>", [[<md>lua vim.lsp.buf.signature_help()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], noremap_silent)
  buf_set_keymap("n", "<Leader>wa", [[<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]], noremap_silent)
  buf_set_keymap("n", "<Leader>wr", [[<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]], noremap_silent)
  buf_set_keymap("n", "<Leader>wl", [[<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>D", [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>rn", [[<cmd>lua vim.lsp.buf.rename()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>e", [[<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]], noremap_silent)
  buf_set_keymap("n", "[d", [[<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]], noremap_silent)
  buf_set_keymap("n", "]d", [[<cmd>lua vim.lsp.diagnostic.goto_next()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>q", [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]], noremap_silent)
  -- buf_set_keymap("n", "<Leader>l", [[<cmd>lua require'lsp-codelens'.buf_codelens_action()<CR>]], noremap_silent)
  vim.cmd [[command! Format execute 'lua vim.lsp.buf.formatting()']]

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then buf_set_keymap("n", "K", [[<Cmd>lua vim.lsp.buf.hover()<CR>]], noremap_silent) end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup lsp_codelens
      autocmd! * <buffer>
      autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua require"lsp-codelens".buf_codelens_refresh()
    augroup END
    ]]
  end

  if client.server_capabilities.colorProvider then
    require"lsp-documentcolors".buf_attach(bufnum, { single_column = true })
  end

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then
    buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", noremap_silent)
  end
end

local texlab_settings = {
    texlab = {
        build = {
            onSave = true,
            forwardSearchAfter = false
        },
        forwardSearch = {
            executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
            args =  {"%l", "%p", "%f"}
        }
    }
}

local lsp_installer = require("nvim-lsp-installer")
local servers = {
    "sumneko_lua",
    "pyright",
    "texlab",
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

lsp_installer.on_server_ready(function(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities
    }
    if server.name == "texlab" then
        opts.settings = texlab_settings
    end
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

