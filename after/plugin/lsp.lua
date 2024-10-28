vim.diagnostic.config({ virtual_text = false, update_in_insert = true })

local lsp = require("lsp-zero").preset({})
local cmp_action = require("lsp-zero").cmp_action()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Insert }
local luasnip = require('luasnip')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
      vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
        col)
      :match("%s") == nil
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- regular selection
        cmp.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true
        })
      elseif luasnip.expand_or_locally_jumpable() then
        -- trigger snippet
        luasnip.expand_or_jump()
      elseif has_words_before() then
        -- if non-whitespace before cursor, trigger completion menu
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- consume word after cursor (<Tab> behaviour is to prepend to it)
        cmp.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace
        })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end)
  }),
  snippet = {
    expand = function(args) require "luasnip".lsp_expand(args.body) end
  },
  experimental = { ghost_text = { enabled = true, hl_group = "Comment" } }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws",
    function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd",
    function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
    opts)
  vim.keymap.set("n", "<C-a>", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
    opts)
  vim.keymap
      .set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end,
    opts)
  vim.keymap.set("n", "<leader>gh",
    function() vim.cmd("ClangdSwitchSourceHeader") end, opts)
end)

require("mason").setup {}
require("mason-lspconfig").setup({
  ensure_installed = {},
  handlers = {
    lsp.default_setup,
    clangd = function()
      require("lspconfig").clangd.setup({
        cmd = { "clangd", "--query-driver=**" }
      })
    end,
    asm_lsp = function()
      require("lspconfig").asm_lsp.setup({
        filetypes = { "s", "asm", "nasm" }
      })
    end,
    yamlls = function()
      require('lspconfig')['yamlls'].setup {
        settings = {
          yaml = {
            validate = true,
            -- disable the schema store
            schemaStore = { enable = false, url = "" },
            schemas = {
              kubernetes = "*.yaml",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
              ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
              ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
              ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
              ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
              ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
              ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}"
            }
          }
        }
      }
    end,
    html = function()
      require('lspconfig').html.setup { filetypes = { "html", "templ" } }
    end,
    htmx = function()
      require('lspconfig').htmx.setup({ filetypes = { "html", "templ" } })
    end,
    tailwindcss = function()
      require('lspconfig').tailwindcss.setup {
        filetypes = {
          "html", "templ", "javascript", "typescript", "react"
        },
        settings = { tailwindCSS = { includeLanguages = { templ = "html" } } }
      }
    end,
    emmet_language_server = function()
      require('lspconfig').emmet_language_server.setup {
        filetypes = { "templ", "react", "html" },
        init_options = { includeLanguages = { templ = "html" } }
      }
    end
  }
})
require("mason-nvim-dap").setup()

lsp.setup()

vim.diagnostic.config({ virtual_text = true, update_in_insert = true })
