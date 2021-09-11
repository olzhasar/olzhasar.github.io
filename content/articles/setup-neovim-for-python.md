Title: Setting up Neovim for Python development in 2021
Slug: setting-up-neovim-for-python-development
Date: 2021-09-08
Tags: neovim, vim, python
Image: setup-neovim-for-python.jpg
Summary: Neovim is awesome. Let's set it up for efficient Python development!
Status: draft

If you happen to be a Vim fan like myself, I don't need to explain to you how incredible this editor is. But when it comes to developing large projects, can Neovim really compete with all these fancy modern fully-featured IDEs like PyCharm or VSCode? The answer is a strong YES, but we need to make a little a bit of a setup for that. In this article, I will show you some tools that I use on a daily basis with Neovim for developing in Python (and other languages as well).

First, let's clarify what do we really need from a modern IDE besides really basic things like syntax highlighting? I personally came up with the following must-have features:

- Project session management
- Convenient way of working with git
- Easily search files within a project
- Code auto-completion

And luckily, you can add all those features to Neovim in a matter of minutes. Let's go over them one by one.

## Project session management

When developing a large software project, you probably want your development environment to load all files that you've been working on when you closed your project previously. Vim actually has a built-in `:mksession` command that will save your current session in a file on disk. You can later load that session when starting vim using `-S` flag: `vim -S -Session.vim`. However, it's not really convenient having to always remember to invoke `:mksession` command. That's where a handy plugin [vim-obsession](https://github.com/tpope/vim-obsession) comes in. After installing this plugin, you just run `:Obsession` command in your vim. Now, vim will automatically track your current session. You can close it any time, and your project will load as you left it when you start your vim with `vim -S /path/to/Session.vim` next time

## Working with git

There is
