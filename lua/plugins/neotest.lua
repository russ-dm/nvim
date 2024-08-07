return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        {
          ["neotest-rust"] = {
            arg = { "--no-capture" },
          },
          { ["rustaceanvim.neotest"] = {} },
        },
      },
    },
  },
}
