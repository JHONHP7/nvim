return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  ft = { "java", "javascript", "typescript", "html" },
  config = function()
    local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
    local analyzers_dir = mason_path .. "/packages/sonarlint-language-server/extension/analyzers/"
    local jar = analyzers_dir .. "sonarjava.jar"

    if not vim.uv.fs_stat(jar) then
      return
    end

    -- Java (tdtg-service) + JS/TS/HTML (tdtg-web, Angular)
    local analyzers = {}
    for _, name in ipairs({ "sonarjava.jar", "sonarjavasymbolicexecution.jar", "sonarjs.jar", "sonarhtml.jar", "sonarxml.jar", "sonartext.jar" }) do
      if vim.uv.fs_stat(analyzers_dir .. name) then
        table.insert(analyzers, analyzers_dir .. name)
      end
    end

    -- SonarQube da SEFAZ (connected mode): usa as regras do perfil do servidor
    -- sem publicar nada. Token: env SONAR_TOKEN ou arquivo ~/.sonar-token
    local connection_id = "sefaz-rj"

    -- raiz do projeto -> projectKey no SonarQube
    local projects = {
      [vim.fn.expand("$HOME/0work/tdtg-service")] = "br.gov.rj.fazenda:tdtg-service",
      [vim.fn.expand("$HOME/0work/tdtg-web")] = "tdtg-web",
    }

    local function read_token()
      local token = vim.env.SONAR_TOKEN
      if token and #token > 0 then
        return token
      end
      local file = vim.fn.expand("~/.sonar-token")
      if vim.uv.fs_stat(file) then
        return vim.trim(table.concat(vim.fn.readfile(file), ""))
      end
      return nil
    end

    require("sonarlint").setup({
      connected = {
        get_credentials = function()
          return read_token()
        end,
      },
      server = {
        cmd = vim.list_extend({
          "sonarlint-language-server",
          "-stdio",
          "-analyzers",
        }, analyzers),
        settings = {
          sonarlint = {
            connectedMode = {
              connections = {
                sonarqube = {
                  {
                    connectionId = connection_id,
                    serverUrl = "https://sonar.fazenda.rj.gov.br",
                    disableNotifications = false,
                  },
                },
              },
            },
          },
        },
        before_init = function(params, config)
          local root = params.rootPath
          if not root and params.rootUri then
            root = vim.uri_to_fname(params.rootUri)
          end
          local key = root and projects[root]
          if key then
            config.settings.sonarlint.connectedMode.project = {
              connectionId = connection_id,
              projectKey = key,
            }
          end
        end,
      },
      filetypes = { "java", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "python" },
    })
  end,
}
