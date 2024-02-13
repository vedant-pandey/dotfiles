local setup, todocomments = pcall(require, 'todo-comments')
if not setup then
    return
end

todocomments.setup()
