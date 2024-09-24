-- lazy.nvim
return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            providers = {
                openai = {
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    secret = {"cat", "~/.config/nvim/.env/.openai"},
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
                    secret = {"cat", "~/.config/nvim/.env/.anthropic"},
                },
            },
        }
        require("gp").setup(conf)
    end,
}
