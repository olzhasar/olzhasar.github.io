---
title: Supercharge Your Python TDD Workflow With pytest-watcher
date: 2023-06-08T05:37:36+06:00

tags:
  - python
  - programming
---

If you follow the [Test-driven Development](https://en.wikipedia.org/wiki/Test-driven_development) practice in your Python projects, you need to run your test suite **often**. Having to run it manually can become tedious. You can configure handy shortcuts in your favorite IDE to make the process easier. But there is even better way using [`pytest-watcher`](https://pypi.org/project/pytest-watcher/).

## What is `pytest-watcher`?

`pytest-watcher` is a continuous test runner for Python projects that reruns your tests whenever you change a `*.py` file inside your project.

It uses `pytest` as a test runner but you can also configure it to use other test runners (e.g. `tox`, `unittest`, etc.)

## Installing pytest-watcher

You can install the tool like any other Python package with `pip`:

```shell
pip install pytest-watcher
```

## Usage

Navigate to your project directory and start the `pytest-watcher`.

```shell
ptw .
```

This will tell `pytest-watcher` to start listening for filesystem events in the current directory. Now change your code and enjoy your tests restarting automatically.

Demo:
![Demo](/pytest-watcher-demo.gif)

## Additional usage info

Visit [Github repository](https://github.com/olzhasar/pytest-watcher) for additional info about using and configuring `pytest-watcher`
