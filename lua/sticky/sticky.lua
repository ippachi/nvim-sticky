local Sticky = {}

Sticky.__index = Sticky

Sticky.new = function()
  local self = setmetatable({}, { __index = Sticky })
  self.bufnr = vim.api.nvim_create_buf(true, false)
  self.setup(self.bufnr)
  return self
end

Sticky.setup = function(bufnr)
  local sticky_dir_path = string.format('%s/.local/share/nvim/sticky-nvim', vim.env.HOME)
  vim.fn.mkdir(sticky_dir_path, 'p')
  vim.api.nvim_buf_call(bufnr, function()
    vim.fn.execute(string.format('e %s/index.md', sticky_dir_path))
    vim.api.nvim_create_augroup('sticky-nvim', { clear = true })
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, { group = 'sticky-nvim', buffer = vim.g.sticky_nvim_bufnr, callback = function() vim.fn.execute('write') end})
  end)
end

Sticky.attach = function(self)
  vim.api.nvim_open_win(self.bufnr, true, {
    relative = "editor", anchor = "NE",
    width = math.ceil(vim.opt.columns:get()/8), height = math.ceil(vim.opt.lines:get()/8),
    row = 1, col = vim.opt.columns:get() - 2,
    style = "minimal", border = "rounded"
  })
end

Sticky.detach = function(self)
  vim.fn.execute(string.format('%swincmd q', self:winnr()))
end

Sticky.is_attached = function(self)
  return self:winnr() ~= -1
end

Sticky.winnr = function(self)
  return vim.fn.bufwinnr(self.bufnr)
end

Sticky.winid = function(self)
  return vim.fn.win_getid(self:winnr())
end

return Sticky
