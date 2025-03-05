-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

vim.filetype.add({
  pattern = {
    nfo = "xml"
  }
})

require('ik.sketch')


-- an attempt to fix kaocha
vim.g["conjure#client#clojure#nrepl#test#runner"] = "kaocha"
vim.g["conjure#client#clojure#nrepl#test#call_suffix"] = "{:kaocha/color? false, :kaocha/reporter [kaocha.report/documentation], :kaocha/capture-output? false, :kaocha.plugin.randomize/randomize? false}"
