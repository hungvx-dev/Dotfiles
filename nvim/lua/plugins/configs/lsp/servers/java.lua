return {
  enabled = false,
  root_dir = require("lspconfig/util").root_pattern(
    "build.gradle",
    "build.gradle.kts",
    "build.xml",           -- Ant
    "pom.xml",             -- Maven
    "settings.gradle",     -- Gradle
    "settings.gradle.kts", -- Gradle
  ),
  filetypes = { "java" },
}
