-- lazy.nvim
local openai_api_key = vim.fn.system("cat $HOME/.config/nvim/.env/.openai")
local anthropic_api_key = vim.fn.system("cat $HOME/.config/nvim/.env/.anthropic")
return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            providers = {
                openai = {
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    secret = openai_api_key,
                },
                copilot = {
                    endpoint = "https://api.githubcopilot.com/chat/completions",
                    secret = {
                        "bash",
                        "-c",
                        "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
                    },
                },
                ollama = {
                    endpoint = "http://localhost:11434/v1/chat/completions",
                },
                anthropic = {
                    endpoint = "https://api.anthropic.com/v1/messages",
                    secret = anthropic_api_key,
                },
            },
        }
        require("gp").setup(conf)
    end,
}
