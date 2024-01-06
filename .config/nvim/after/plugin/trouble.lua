local status, trouble = pcall(require, "trouble")
if (not status) then return end

local function setKeymap(key, mode)
  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", key, function() trouble.toggle(mode) end, opts)
end

setKeymap("<leader>xx", nil)
setKeymap("<leader>xw", "workspace_diagnostics")
setKeymap("<leader>xd", "document_diagnostics")
setKeymap("<leader>xq", "quickfix")
setKeymap("<leader>xl", "loclist")
setKeymap("gR", "lsp_references")
