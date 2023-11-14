local teles_status, telescope = pcall(require, 'telescope')
if not teles_status then
    return
end

local act_status, actions = pcall(require, 'telescope.actions')
if not act_status then
    return
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist 
            },
        },
    },
})
