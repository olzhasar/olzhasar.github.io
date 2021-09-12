Title: Setting up Neovim for Python development in 2021
Slug: setting-up-neovim-for-python-development
Date: 2021-09-08
Tags: neovim, vim, python
Image: setup-neovim-for-python.jpg
Summary: Neovim is awesome. Let's set it up for efficient Python development!
Status: draft

If you happen to be a Vim fan like myself, I don't need to explain to you how incredible this editor is. But when it comes to developing large projects, can Neovim really compete with all these fancy fully featured IDEs like PyCharm or VSCode? The answer is a strong YES, but we need to make a little a bit of a setup for that. In this article, I will show you some tools that I use on a daily basis with Neovim for developing large software in Python (and other languages as well).

First, let's clarify what do we need from a modern IDE besides basic functionalities like syntax highlighting? I came up with the following set of must-have features:

- Project session management
- Working with git
- Searching files across the whole repository
- Code auto-completion
- Linting and code formatting

And luckily, you can add all those features to Neovim in a matter of minutes. Let's go over them one by one.

## Project session management

When you are developing a large software project, you probably want your environment to load all files that you've been working on when you closed your project before. Vim actually has a built-in `:mksession` command that will save your current session in a file on disk. That session file can be loaded later by starting vim with `-S` flag: `vim -S -Session.vim`. But it's not super convenient having to invoke `:mksession` command every now and then. That's where a handy plugin [vim-obsession](https://github.com/tpope/vim-obsession) from a cool guy named [Tim Pope](https://github.com/tpope) comes in. After installing this plugin, you just run `:Obsession` command in your vim shell. Now, vim will automatically track your current session in `Session.vim` file (you probably want to add it to .gitignore). Now you can safely close your editor any time your want and all the files that you've been working on will be there when you later start vim with `vim -S Session.vim` command.

## Working with git

If you are a bad guy, you probably work with git from your shell and don't want any other tools for that. But, [fugitive plugin](https://github.com/tpope/vim-fugitive) from the already mentioned Tim Pope can make your working with git faster and more convenient. The plugin adds a bunch of default commands to your vim.
