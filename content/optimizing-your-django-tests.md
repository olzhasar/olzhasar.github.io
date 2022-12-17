+++
title = "Optimizing your Django tests"
date = 2021-09-16
+++

If you are working on a large Django project, you probably have lots of automated tests running as part of your CI/CD process. As long as tests run fast, everybody is happy. But as you continue to add more features, your tests start to take more and more time to run and can become a real bottleneck. In this post, I will share some ideas that can help you optimize runtime of your test suite. I assume you are using **pytest**, but recommendations described in this post should be easily applicable to other runners as well.

## Use sqlite3 database engine if you can

If your data layer is simple enough and does not rely on any database vendor-specific fields or indexes, using **sqlite3** as a database engine in your tests can be the easiest way to speed things up. Django uses **in-memory** variant of sqlite database during tests which will avoid any disk IO altogether and make working with database in your tests blazing fast.

Despite outstanding speed improvements, this approach is less safe than using the same db engine in your tests as in your prod environment. There is a little chance of difference in behavior between databases which can potentially lead to uncovered scenarios. For that reason it should probably be avoided for large projects with critical functionality.

## Optimize migrations

Every time your test suite starts to run, Django will create an empty database and then run all migrations to create necessary schema. This can take long time, especially if there is a latency between your test runner and test database.

### Create test database directly from models

One possible optimization is to create a test database directly from Django models without running any migrations. `pytest-django` has a special flag [--no-migrations](https://pytest-django.readthedocs.io/en/latest/database.html#no-migrations-disable-django-migrations) for that. This approach will reduce db creation time if you have lots of migrations in your project. The downside is that you will lose data migrations as well, which some projects may need to rely on in their tests.

### Squash existing migrations

Another solution is to squash your existing migrations. Django provides a management command called [squashmigrations](https://docs.djangoproject.com/en/dev/topics/migrations/#migration-squashing). You probably should be squashing your migrations periodically not only to speed tests but also to avoid pollution of your codebase.

### Use a pre-made dump to create your database

Sometimes squashing is not an easy option, e.g. when your migrations rely heavily on `RunPython` and `RunSQL` commands. In that case there is another solution which I applied to a project with immense amount of migrations. The idea is to create a cron task that will periodically take the recent codebase from your stable branch, create a new database by applying all migrations and upload a resulting dump to a place where it can be downloaded later by your CI runner. In order for this method to work, you need to customize how your test database is being created. `pytest-django` has [django-db-setup](https://pytest-django.readthedocs.io/en/latest/database.html#django-db-setup) fixture which can be customized to alter database creation process. You need to change it to use a pre-made dump instead of creating database from scratch. After creating the database, only newly added migrations are left to be applied which can save a lot of time.
