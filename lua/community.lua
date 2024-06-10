-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- ok, but too bleak
  { import = "astrocommunity.colorscheme.everforest" },
  -- the best, but why all of them are so blue?
  { import = "astrocommunity.colorscheme.night-owl-nvim" },
  -- { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
}
