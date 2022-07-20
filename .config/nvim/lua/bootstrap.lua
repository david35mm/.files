local PKGS = {
    "savq/paq-nvim",
    "lukas-reineke/indent-blankline.nvim",
    "navarasu/onedark.nvim",
    "norcalli/nvim-colorizer.lua",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter",
    {"echasnovski/mini.nvim", branch = "stable"},
}
local function clone_paq()
    local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
    if vim.fn.empty(vim.fn.glob(path)) > 0 then
        vim.fn.system {
            "git",
            "clone",
            "--depth=1",
            "https://github.com/savq/paq-nvim.git",
            path,
        }
    end
end
local function bootstrap_paq()
    clone_paq()
    -- Load Paq
    vim.cmd("packadd paq-nvim")
    local paq = require("paq")
    -- Exit nvim after installing plugins
    vim.cmd("autocmd User PaqDoneInstall quit")
    -- Read and install packages
    paq(PKGS)
    paq.install()
end
return {bootstrap_paq = bootstrap_paq}
