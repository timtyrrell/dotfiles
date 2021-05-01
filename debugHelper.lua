local dap = require('dap')

local function debugJest(testName, fileName)
  print("starting " .. testName .. " with file " .. fileName)
  dap.run({
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest', '--no-coverage', '-t', string.format("%s", testName), '--', fileName},
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229,
  })
end

local function attach()
  print("attaching")
  dap.run({
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
  })
end

return {
  debugJest = debugJest,
  attach = attach,
}
