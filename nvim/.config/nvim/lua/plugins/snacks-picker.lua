return {
  "snacks.nvim",
  opts = {
    picker = {
      sources = {
        grep = {
          layout = { fullscreen = true },
          exclude = {
            -- JS/TS lock files & generated
            "package-lock.json",
            "yarn.lock",
            "pnpm-lock.yaml",
            "bun.lockb",
            "*.snap",
            "*.min.js",
            "*.min.css",
            "*.chunk.js",
            "*.bundle.js",
            "*.map",
            "**/.yarn/*",
            -- Go
            "**/go.sum",
            "**/vendor/*",
            -- Docker
            "**/docker-compose.override.yml",
            -- Build/generated output (if committed)
            "*.generated.*",
            "*.codegen.*",
            "**/dist/*",
            "**/build/*",
            "**/.next/*",
            "**/.monorise/*",
            -- SST (v2 & v3)
            "**/.sst/*",
            "**/.build/*",
            "**/sst-env.d.ts",
            "**/node_modules/*"
          },
        },
        files = {
          layout = { fullscreen = true, preview = false },
          formatters = { file = { filename_first = true } },
        },
      },
      win = {
        input = {
          keys = {
            ["<C-g>"] = false,
            ["<C-l>"] = { "toggle_live", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
