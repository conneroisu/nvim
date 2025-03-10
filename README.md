# conneroisu-nvim

## Introduction

Conner Ohnesorge's Personal Neovim Configuration.

Languages setup for:
- [ Lua ](https://lua.org/)
- [ Python ](https://www.python.org/)
- [ Shell (Zsh) ](https://www.zsh.org/)
- [ Bash ](https://www.gnu.org/software/bash/)
- [ Markdown ](https://www.markdownguide.org/)
- [ JSON ](https://www.json.org/)
- [ YAML ](https://yaml.org/)
- [ TOML ](https://toml.io/)
- [ HTML ](https://www.w3.org/TR/html/)
- [ CSS ](https://www.w3.org/Style/CSS/)
- [ JavaScript ](https://www.ecma-international.org/publications/standards/Ecma-262.htm)
- [ TypeScript ](https://www.typescriptlang.org/)
- [ Rust ](https://www.rust-lang.org/)
- [ Zig ](https://ziglang.org/)
- [ C ](https://en.wikipedia.org/wiki/C_(programming_language))
- [ C++ ](https://en.wikipedia.org/wiki/C%2B%2B)
- [ C# ](https://docs.microsoft.com/en-us/dotnet/csharp/)
- [ Java ](https://www.java.com/)
- [ Kotlin ](https://kotlinlang.org/)
- [ Golang ](https://go.dev/)
- [ Ocaml ](https://ocaml.org/)
- [ Templ ](https://templ.guide/)
- [ Dockerfile ](https://docs.docker.com/engine/reference/builder/)
- [ Docker Compose ](https://docs.docker.com/compose/)
- [ PHP ](https://www.php.net/)
- [ R ](https://www.r-project.org/)
- [ Vimscript ](https://vim.fandom.com/wiki/Vimscript)

- [ Sqlite ](https://www.sqlite.org/index.html)
- [ PostgreSQL ](https://www.postgresql.org/)
- [ MySQL ](https://www.mysql.com/)

- [ MIPS ](https://mips.com/)
- [ ARM ](https://en.wikipedia.org/wiki/ARM_architecture)
- [ RISC-V ](https://en.wikipedia.org/wiki/RISC-V)
- [ x86 ](https://en.wikipedia.org/wiki/X86)
- [ x86-64 ](https://en.wikipedia.org/wiki/X86-64)

## Installation (Of configuration)

1. Clone this repository into your Neovim configuration directory.

For example, for linux and MacOS:

```bash
git clone https://github.com/conneroisu/nvim ~/.config/nvim
```

For windows:

```bash
git clone https://github.com/conneroisu/conneroisu-nvim %USERPROFILE%\AppData\Local\nvim
```

2. Open Neovim.

```bash
nvim
```

## Customizing Plugin Specifications with Lazy 

Defaults merging rules:

- `cmd`: the list of commands will be extended with your custom commands
- `event`: the list of events will be extended with your custom events
- `ft`: the list of filetypes will be extended with your custom filetypes
- `keys`: the list of keymaps will be extended with your custom keymaps
- `opts`: your custom options will be merged with the default options
- `dependencies`: the list of dependencies will be extended with your custom dependencies any other property will override the defaults
- `enabled`: Enables or disables the plugin
