-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

-- M.ui = {
--   statusline = {
--     -- Override the built-in fileInfo module
--     overriden_modules = function()
--       return {
--         fileInfo = function()
--           -- Use "%:p" for absolute path, or "%:~:." for home-relative/project-relative path
--           local path = vim.fn.expand("%:p") 
--           if path == "" then 
--             return " Empty " 
--           end
          
--           -- Get the icon for the file type
--           local icon = "    "
--           local filename = vim.fn.expand("%:t")
--           local devicons_present, devicons = pcall(require, "nvim-web-devicons")
--           if devicons_present then
--             local ft_icon = devicons.get_icon(filename)
--             icon = ft_icon and (" " .. ft_icon) or icon
--           end

--           -- Return the formatted block (adjust background/foreground highlights if desired)
--           return "%#St_file_info#" .. icon .. path .. " "
--         end
--       }
--     end
--   }
-- }

M.ui = {
  statusline = {
    modules = {
      -- Override the default file module to show the full path instead of
      -- just the filename. Paths under $HOME shorten to ~/.
      -- Show the path relative to the git repo root, so files in worktrees
      -- show as os/package/foo.lua rather than the long .worktrees prefix.
      -- Outside a repo, show the full path with $HOME shortened to ~.
      file = function()
        local utils = require "nvchad.stl.utils"
        local x = utils.file()
        local path = vim.api.nvim_buf_get_name(utils.stbufnr())

        if path == "" then
          path = "Empty"
        else
          local root = vim.fs.root(utils.stbufnr(), ".git")
          path = root and vim.fs.relpath(root, path) or vim.fn.fnamemodify(path, ":~")
        end

        local sep_style = require("nvconfig").ui.statusline.separator_style
        local separators = (type(sep_style) == "table" and sep_style) or utils.separators[sep_style]

        return "%#St_file# " .. x[1] .. " " .. path .. " %#St_file_sep#" .. separators.right
      end,
    },
  },
}

return M
