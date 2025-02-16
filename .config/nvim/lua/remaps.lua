vim.keymap.set("n", "<leader>fv", ":Explore<CR>", { noremap = true, silent = true})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })




local ts_utils = require("nvim-treesitter.ts_utils")

function GetCurrentFunctionName()
    local node = ts_utils.get_node_at_cursor()
    if not node then return "No function found" end

    while node do
        if node:type() == "function_declaration" or node:type() == "method_declaration" then
            local name_node = node:field("name")[1]
            if name_node then
                return vim.treesitter.get_node_text(name_node, 0)
            end
        end
        node = node:parent()
    end
    return "No function found"
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function run_command_with_telescope(cmd)
    local output = vim.fn.systemlist(cmd)  -- Runs the command and returns a table of lines

    pickers.new({}, {
        prompt_title = "Command Output",
        finder = finders.new_table({
            results = output,
        }),
        sorter = conf.generic_sorter({}),
    }):find()
end

run_tests = function(all)
    local curFunc = GetCurrentFunctionName()
    local curFile = vim.fn.expand("%")
    local cmd = "go test -v " .. curFile
    if all ~= true then
        cmd = cmd .. " -run " .. curFunc
    end
    --local cmd = "go test -v " .. curFile .. " -run " .. curFunc
    --run_command_in_float(cmd)
    run_command_with_telescope(cmd)
    --local output = vim.fn.system("go test -v " .. curFile .. " -run " .. curFunc)
    --print(output)
end

vim.keymap.set('n', '<leader>rt', ":lua run_tests()<CR>", { desc = 'Run tests for current func' })
vim.keymap.set('n', '<leader>rat', ":lua run_tests(true)<CR>", { desc = 'Run all tests in file' })
