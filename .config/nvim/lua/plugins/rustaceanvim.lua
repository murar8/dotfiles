return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            procMacro = {
              enable = true,
              ignored = {
                -- Remove "async-trait" from the default ignored list
                -- Keep other commonly problematic macros
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
  },
}