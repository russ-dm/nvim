-- autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })
--
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  buffer = 0,
  callback = function()
    local count = 0
    local function refresh()
      if count < 12 then
        vim.lsp.codelens.refresh({ bufnr = 0 })
        count = count + 1
        vim.defer_fn(refresh, 5000) -- 5000 milliseconds = 5 seconds
      end
    end
    refresh() -- Initial call
  end,
})
