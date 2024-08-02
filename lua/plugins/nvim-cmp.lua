-- nvim-cmp configs
-- source: https://www.barbarianmeetscoding.com/notes/neovim-lazyvim/#custom-nvim-cmp-configs
return {
  -- customize nvim-cmp configs
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "brenoprata10/nvim-highlight-colors",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.formatting = {
        -- format = require("nvim-highlight-colors").format,
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
              Codeium = "",
            }, --
          })(entry, item)

          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "

          return kind
        end,
      }
      table.insert(opts.sources, { name = "emoji" })
      opts.window = {
        completion = {
          border = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
          --border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
          --winhighlight = "FloatBorder:FloatBorder,CursorLine:CursorLine",
        },
        documentation = {
          max_width = 50,
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          --border = { "┌", " ", "┐", "│", "┘", " ", "└", "│" },
          --winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      }

      -- This is reaaaally not easy to setup :D
      opts.mapping = vim.tbl_extend("force", opts.mapping, {

        ["<Tab>"] = cmp.mapping(function(fallback)
          -- If it's a snippet then jump between fields
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          -- otherwise if the completion pop is visible then complete
          elseif cmp.visible() then
            cmp.confirm({ select = false })
          -- if the popup is not visible then open the popup
          elseif has_words_before() then
            cmp.complete()
          -- otherwise fallback
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
