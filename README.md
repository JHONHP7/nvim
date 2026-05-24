# Neovim Config — Guia Completo

> Setup pessoal para desenvolvimento Java/Spring Boot, Angular, TypeScript e Docker no WSL (Ubuntu) + Zsh.

---

## Índice

- [Pré-requisitos](#pré-requisitos)
- [Instalação passo a passo](#instalação-passo-a-passo)
- [Plugins instalados](#plugins-instalados)
- [Todos os atalhos](#todos-os-atalhos)
- [Como usar cada funcionalidade](#como-usar-cada-funcionalidade)

---

## Pré-requisitos

Antes de instalar o Neovim, instale as dependências no WSL:

```bash
# Atualizar o sistema
sudo apt update && sudo apt upgrade -y

# Dependências base
sudo apt install -y git curl unzip ripgrep make

# Node.js (para LSPs de JS/TS, prettier, etc)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Java 17+ (para o jdtls)
sudo apt install -y openjdk-17-jdk

# Verificar versões
node --version
java --version
```

---

## Instalação passo a passo

### 1. Instalar o Neovim 0.12+

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
nvim --version
```

### 2. Configurar o Zsh

Adicione ao `~/.zshrc`:

```bash
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias vi="nvim"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
```

Recarregue:

```bash
source ~/.zshrc
```

### 3. Instalar a config

```bash
# Backup da config anterior (se existir)
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# Criar a estrutura
mkdir -p ~/.config/nvim/lua/plugins

# Copiar os arquivos desta config para ~/.config/nvim/
```

### 4. Baixar o Lombok

```bash
mkdir -p ~/.config/nvim/lombok
curl -L https://projectlombok.org/downloads/lombok.jar \
  -o ~/.config/nvim/lombok/lombok.jar
```

### 5. Instalar Nerd Font (Windows Terminal)

1. Baixe uma fonte em https://www.nerdfonts.com/font-downloads (recomendado: **JetBrainsMono Nerd Font**)
2. Instale no Windows (duplo clique no `.ttf`)
3. No Windows Terminal: Configurações → Perfil Ubuntu → Aparência → Fonte → selecione a Nerd Font

### 6. Primeira abertura do Neovim

```bash
nvim
```

O lazy.nvim vai instalar todos os plugins automaticamente. Aguarde terminar e feche com `:q`.

### 7. Instalar LSPs e ferramentas pelo Mason

Abra o nvim e rode:

```
:Mason
```

Instale com `i` em cima de cada um, ou use `:MasonInstall`:

```
:MasonInstall jdtls
:MasonInstall typescript-language-server
:MasonInstall html-lsp
:MasonInstall lua-language-server
:MasonInstall dockerfile-language-server
:MasonInstall css-lsp
:MasonInstall json-lsp
:MasonInstall yaml-language-server
:MasonInstall angular-language-server
:MasonInstall sonarlint-language-server
:MasonInstall vscode-spring-boot-tools
:MasonInstall google-java-format
:MasonInstall prettier
:MasonInstall eslint_d
:MasonInstall stylelint
:MasonInstall hadolint
:MasonInstall stylua
```

### 8. Autenticar o GitHub Copilot

```
:Copilot auth
```

Acesse o link que aparecer, insira o código e autorize no GitHub.

---

## Plugins instalados

| Plugin | Função | Repositório |
|--------|---------|-------------|
| lazy.nvim | Gerenciador de plugins | https://github.com/folke/lazy.nvim |
| catppuccin | Tema (mocha) | https://github.com/catppuccin/nvim |
| alpha-nvim | Dashboard de boas-vindas | https://github.com/goolord/alpha-nvim |
| lualine.nvim | Barra de status | https://github.com/nvim-lualine/lualine.nvim |
| neo-tree.nvim | Sidebar de arquivos | https://github.com/nvim-neo-tree/neo-tree.nvim |
| oil.nvim | Navegador de arquivos em float | https://github.com/stevearc/oil.nvim |
| telescope.nvim | Busca de arquivos e texto | https://github.com/nvim-telescope/telescope.nvim |
| nvim-treesitter | Syntax highlighting avançado | https://github.com/nvim-treesitter/nvim-treesitter |
| nvim-lspconfig | Configuração de LSPs | https://github.com/neovim/nvim-lspconfig |
| mason.nvim | Gerenciador de LSPs/ferramentas | https://github.com/williamboman/mason.nvim |
| mason-lspconfig | Integração Mason + LSP | https://github.com/williamboman/mason-lspconfig.nvim |
| nvim-cmp | Autocomplete | https://github.com/hrsh7th/nvim-cmp |
| LuaSnip | Snippets | https://github.com/L3MON4D3/LuaSnip |
| none-ls.nvim | Formatadores e linters | https://github.com/nvimtools/none-ls.nvim |
| gitsigns.nvim | Indicadores git nas linhas | https://github.com/lewis6991/gitsigns.nvim |
| vim-fugitive | Git completo dentro do nvim | https://github.com/tpope/vim-fugitive |
| vim-test | Rodar testes | https://github.com/vim-test/vim-test |
| vimux | Rodar comandos no tmux/terminal | https://github.com/preservim/vimux |
| sonarlint.nvim | Análise de qualidade de código | https://gitlab.com/schrieveslaach/sonarlint.nvim |
| copilot.vim | GitHub Copilot (sugestões inline) | https://github.com/github/copilot.vim |
| CopilotChat.nvim | Chat com o Copilot | https://github.com/CopilotC-Nvim/CopilotChat.nvim |

---

## Todos os atalhos

> `Leader` = `Espaço`

### Navegação — panes e janelas

| Atalho | Ação |
|--------|------|
| `Ctrl+h` | Move para o pane da esquerda |
| `Ctrl+j` | Move para o pane de baixo |
| `Ctrl+k` | Move para o pane de cima |
| `Ctrl+l` | Move para o pane da direita |
| `Ctrl+n` | Toggle sidebar (neo-tree) |
| `Ctrl+t` | Toggle terminal horizontal |
| `Leader+bf` | Buffers abertos em float |
| `Leader+h` | Remove highlight de busca |
| `:vs` | Split vertical |
| `:sp` | Split horizontal |
| `:bd` | Fecha o buffer atual |

### Telescope — busca

| Atalho | Ação |
|--------|------|
| `Ctrl+p` | Busca arquivos no projeto |
| `Leader+fg` | Busca texto em todos os arquivos (live grep) |
| `Leader+Space` | Arquivos abertos recentemente |

> Dentro do Telescope: `Ctrl+j/k` navega, `Enter` abre, `Esc` fecha

### Oil — navegador de arquivos

| Atalho | Ação |
|--------|------|
| `-` | Abre oil em float (pasta do arquivo atual) |

> Dentro do oil: `Enter` abre, `-` sobe pasta, `_` vai para raiz, `g?` ajuda

### Neo-tree — sidebar

| Atalho | Ação |
|--------|------|
| `Ctrl+n` | Toggle abrir/fechar sidebar |
| `Leader+bf` | Buffers em float |

> Dentro do neo-tree: `a` novo arquivo, `d` deletar, `r` renomear, `?` ajuda

### LSP — código e diagnósticos

| Atalho | Ação |
|--------|------|
| `K` | Documentação/hover do símbolo |
| `Leader+gd` | Vai para a definição |
| `Leader+gr` | Lista todas as referências |
| `Leader+ca` | Code actions (sugestões, imports) |
| `Leader+rn` | Renomeia símbolo em todo o projeto |
| `Leader+e` | Mostra erro/diagnóstico em float |
| `[d` | Diagnóstico anterior |
| `]d` | Próximo diagnóstico |
| `Leader+gf` | Formata o arquivo atual |

### Autocomplete (nvim-cmp)

| Atalho | Ação |
|--------|------|
| `Ctrl+Space` | Força abrir o menu |
| `Enter` | Confirma a sugestão |
| `Ctrl+e` | Fecha o menu |
| `Ctrl+b` | Scrolla documentação para cima |
| `Ctrl+f` | Scrolla documentação para baixo |

### Copilot — sugestões inline

| Atalho | Ação |
|--------|------|
| `Ctrl+l` | Aceita a sugestão |
| `Alt+]` | Próxima sugestão |
| `Alt+[` | Sugestão anterior |
| `Alt+e` | Dispensa a sugestão |

### Copilot Chat

| Atalho | Ação |
|--------|------|
| `Leader+cc` | Abre o chat |
| `Leader+cq` | Pergunta rápida |
| `Leader+ce` | Explica código selecionado (modo visual) |
| `Leader+cr` | Revisa código selecionado (modo visual) |
| `Leader+cf` | Corrige código selecionado (modo visual) |
| `Leader+ct` | Gera testes do código selecionado (modo visual) |

### Git

| Atalho | Ação |
|--------|------|
| `Leader+gp` | Preview do hunk (diff da linha) |
| `Leader+gt` | Toggle git blame na linha |
| `:Git` | Painel git completo (status, stage, commit) |
| `:Git diff` | Diff do arquivo atual |
| `:Git log` | Histórico de commits |
| `:Git blame` | Blame linha a linha |
| `:Git add %` | Stage do arquivo atual |

> Dentro do `:Git`: `s` stage, `u` unstage, `cc` commit, `?` ajuda

### Testes (vim-test)

| Atalho | Ação |
|--------|------|
| `Leader+t` | Roda o teste mais próximo do cursor |
| `Leader+T` | Roda todos os testes do arquivo |
| `Leader+a` | Roda toda a suite |
| `Leader+l` | Roda o último teste executado |
| `Leader+g` | Vai para o arquivo de teste |

### Vim — movimentação

| Atalho | Ação |
|--------|------|
| `gg` | Primeira linha |
| `G` | Última linha |
| `69G` | Vai para a linha 69 |
| `:69` | Vai para a linha 69 |
| `Ctrl+d` | Desce meia tela |
| `Ctrl+u` | Sobe meia tela |
| `zz` | Centraliza na linha atual |
| `w` | Próximo começo de palavra |
| `b` | Começo da palavra anterior |
| `0` | Início da linha |
| `$` | Fim da linha |
| `%` | Par do colchete/parêntese |

### Vim — edição

| Atalho | Ação |
|--------|------|
| `yy` | Copia a linha |
| `yy p` | Duplica a linha (copia e cola abaixo) |
| `dd` | Deleta a linha |
| `p` | Cola abaixo |
| `P` | Cola acima |
| `u` | Desfaz |
| `Ctrl+r` | Refaz |
| `>>` | Indenta para direita |
| `<<` | Indenta para esquerda |
| `=G` | Indenta do cursor até o fim |
| `J` | Junta linha atual com a de baixo |
| `~` | Alterna maiúscula/minúscula |
| `Ctrl+a` | Incrementa número sob o cursor |
| `Ctrl+x` | Decrementa número sob o cursor |
| `di"` | Deleta conteúdo dentro das aspas |
| `ci(` | Muda conteúdo dentro dos parênteses |
| `gc` | Comenta linha/seleção |

### Vim — modos

| Atalho | Ação |
|--------|------|
| `i` | Modo insert (antes do cursor) |
| `a` | Modo insert (depois do cursor) |
| `o` | Nova linha abaixo e insert |
| `v` | Modo visual (caracteres) |
| `V` | Modo visual linha |
| `Esc` | Volta ao modo normal |
| `/texto` | Busca no arquivo |
| `n` | Próxima ocorrência da busca |
| `N` | Ocorrência anterior da busca |

### Vim — salvar e sair

| Atalho | Ação |
|--------|------|
| `:w` | Salva |
| `:q` | Fecha |
| `:wq` | Salva e fecha |
| `:q!` | Fecha sem salvar |

---

## Como usar cada funcionalidade

### Rodar projeto Spring Boot

```bash
# Com profile de teste
./mvnw spring-boot:run -Dspring-boot.run.profiles=test

# Gradle
./gradlew bootRun --args='--spring.profiles.active=test'
```

Use `Ctrl+t` para abrir o terminal integrado dentro do nvim e rodar esses comandos.

### Instalar/gerenciar LSPs

```
:Mason          → abre interface visual
:MasonInstall X → instala pelo nome
:MasonUninstall X → remove
```

### Ver LSPs ativos no arquivo atual

```lua
:lua vim.print(vim.lsp.get_clients())
```

### Verificar saúde do LSP

```
:checkhealth lsp
```

### Atualizar plugins

```
:Lazy update
```

### Limpar plugins não usados

```
:Lazy clean
```

---

## Estrutura de arquivos da config

```
~/.config/nvim/
├── init.lua                    ← bootstrap do lazy + carrega tudo
├── lazy-lock.json              ← versões travadas dos plugins
├── lombok/
│   └── lombok.jar              ← agente do Lombok para o jdtls
└── lua/
    ├── vim-options.lua         ← opções gerais e keymaps globais
    ├── plugins.lua             ← entry point (retorna {})
    └── plugins/
        ├── alpha.lua           ← dashboard
        ├── catppuccin.lua      ← tema
        ├── completions.lua     ← autocomplete (nvim-cmp + LuaSnip)
        ├── copilot.lua         ← GitHub Copilot + CopilotChat
        ├── git-stuff.lua       ← gitsigns + vim-fugitive
        ├── lsp-config.lua      ← Mason + LSPs (Java, TS, HTML, etc)
        ├── lualine.lua         ← barra de status
        ├── neo-tree.lua        ← sidebar de arquivos
        ├── none-ls.lua         ← formatadores e linters
        ├── oil.lua             ← navegador de arquivos em float
        ├── sonarlint.lua       ← análise de qualidade
        ├── telescope.lua       ← busca de arquivos e texto
        ├── treesitter.lua      ← syntax highlighting
        └── vim-test.lua        ← rodar testes
```

---

## Links úteis

- Neovim releases: https://github.com/neovim/neovim/releases
- lazy.nvim: https://github.com/folke/lazy.nvim
- Mason: https://github.com/williamboman/mason.nvim
- Nerd Fonts: https://www.nerdfonts.com/font-downloads
- Lombok: https://projectlombok.org/download
- Copilot: https://github.com/features/copilot
- nvim-lspconfig LSPs disponíveis: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
