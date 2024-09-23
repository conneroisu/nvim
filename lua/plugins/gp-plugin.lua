-- lazy.nvim
return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            providers = {
                openai = {
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    secret = os.getenv("OPENAI_API_KEY"),
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
                googleai = {
                    endpoint =
                    "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
                    secret = os.getenv("GOOGLEAI_API_KEY"),
                },

                anthropic = {
                    endpoint = "https://api.anthropic.com/v1/messages",
                    secret = os.getenv("ANTHROPIC_API_KEY"),
                },
            },
        }
        require("gp").setup(conf)
    end,
}
