return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    -- C#
    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
        env = {
          ASPNETCORE_ENVIRONMENT = "Development",
          ASPNETCORE_URLS = "http://localhost:5000",
        },
      },
    }

    vim.keymap.set("n", "<leader>db", function()
      require("dap").toggle_breakpoint()
    end)
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end)
    vim.keymap.set("n", "<leader>di", function()
      require("dap").step_into()
    end)
    vim.keymap.set("n", "<leader>do", function()
      require("dap").step_out()
    end)
    vim.keymap.set("n", "<leader>dO", function()
      require("dap").step_over()
    end)
    vim.keymap.set("n", "<leader>dt", function()
      require("dap").terminate()
    end)

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "blue" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "yellow" })
  end,
}
