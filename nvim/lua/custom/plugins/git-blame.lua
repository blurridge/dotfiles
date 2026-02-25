return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function(_, opts)
        require("gitblame").setup(opts)
        vim.cmd("cabbrev gbo GitBlameOpenCommitURL")
    end,
    opts = {
        enabled = true,
        message_template = "<author>, <date> • <summary>",
        date_format = "%x",
        virtual_text_column = 1,
        set_extmark_options = {
            hl_mode = "combine",
        },
    },
}
