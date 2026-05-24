local jdtls = require("jdtls")

local home = os.getenv("HOME")
local mason = vim.fn.stdpath("data") .. "/mason/packages"

local workspace = home
    .. "/.cache/jdtls/"
    .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local bundles = {
  vim.fn.glob(
    mason .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true
  ),
}

vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason .. "/java-test/extension/server/*.jar", true),
    "\n"
  )
)

local config = {
  cmd = {
    "java",
    "-javaagent:" .. home .. "/.config/nvim/lombok/lombok.jar",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(mason .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", mason .. "/jdtls/config_linux",
    "-data", workspace,
  },

  root_dir = require("jdtls.setup").find_root({
    ".git", "mvnw", "gradlew", "pom.xml", "build.gradle",
  }),

  init_options = {
    bundles = bundles,
  },

  on_attach = function(_, bufnr)
    -- Ativa o debug adapter
    jdtls.setup_dap({ hotcodereplace = "auto" })

    -- Keymaps específicos para Java
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
    vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
    vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)
    vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method(true) end, opts)

    -- Rodar testes Java
    vim.keymap.set("n", "<leader>tm", function() jdtls.test_nearest_method() end, opts)
    vim.keymap.set("n", "<leader>tc", function() jdtls.test_class() end, opts)
  end,
}

jdtls.start_or_attach(config)
