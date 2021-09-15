Title: Optimizing tests execution time of your Django app
Slug: optimizing-tests-execution-time-of-your-django-app
Date: 2021-09-16
Tags: python, django, pytest
Summary: A couple of ideas that can make your test suite run faster
Status: published

If you are working on a large Django project, you probably have lots of automated tests running as part of your CI/CD process. As long as tests run fast, everything is good. But as your codebase continue to grow, you are adding more and more of them which can result in degraded performance and slower iterations. In this post, I will share some ideas that can optimize runtime of your test suite. I assume you use `pytest` to run your tests, but almost all topics can be 

## Use `sqlite3` database engine if you can

If your data layer is relatively simple and does not rely on any database vendor-specific fields or indexes, using `sqlite3` as a database engine in your tests can significantly speed up running time. Django uses **in-memory** variant of sqlite database during tests which will avoid any disk IO altogether and make your database tests blazing fast.

Despite outstanding speed improvements, this approach is still less safe than using the same db engine in your test and prod environment. For that reason it should probably be avoided for large projects with critical functionality.

## Optimize migrations

Every time your test suite starts to run, Django will create an empty database and then run all migrations to create tables. This can take long time, especially if there is a latency between your test runner and test database.

### Create test database directly from models

First possible optimization here is to create a tests database from directly from models without running any migrations. `pytest-django` has a special flag [--no-migrations](https://pytest-django.readthedocs.io/en/latest/database.html#no-migrations-disable-django-migrations) for that. That can be a lot faster if you have lots of migrations in your project

### Squash existing migrations

Another solution is to squash your existing migrations. Squashing means reducing quantity of migrations without losing their side effect. You can use Django's built-in [squashmigrations command](https://docs.djangoproject.com/en/dev/topics/migrations/#migration-squashing) for that.

### Use a pre-made dump to create your database

Sometimes squashing is hardly an option, e.g. when your migrations rely heavily on `RunPython` and `RunSQL` commands. In that case there is another solution which I used for a project with immense amount of migrations. Tests were running too slow in a CI runner because of the preparation step in which migrations were applied. The idea is to create a script that will periodically take the recent codebase from the stable branch, create a new database by applying all migrations and upload a resulting dump to a place where it can be later downloaded. In order for this method to work, you need to customize how your test database is being created. `pytest-django` has a [special fixture](https://pytest-django.readthedocs.io/en/latest/database.html#django-db-setup) that is responsible for database creation. You can customize this fixture to use a downloaded dump. After that, only new migrations (if any) will be applied which can significantly reduce database preparation time (as it was in my case).
