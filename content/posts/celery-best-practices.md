---
title: "Celery Best Practices"
date: 2024-12-02T03:42:54+05:00
draft: false
---

Celery is the default choice whenever there is a need to introduce a worker queue into Python projects. Not not exactly ideal, but it's feature-rich, gets the job done, and **can be reliable** when being used **properly**. Over the years of working with Celery, I've developed certain rules that I would recommend one to follow for building reliable background pipelines.

## Prefer late acknowledgement

In the context of background job queues, acknowledgment is the process of notifying the queue that a particular job has been completed. In most cases it means the job can now be removed from the queue. By default, Celery uses early acknowledgment, meaning the queue is acknowledged as soon as the child worker starts the job. What is the problem here? Well, the worker can simply crash (by receiving a `SIGKILL` for example) and the task will now be lost without any option to rerun it.

**Late acknowledgment** solves this problem by keeping the task in the queue until the worker finishes it and notifies the master worker about it. Now if the worker crashes mid-execution, the master process will simply redistribute the job to a different worker.

Why isn't late acknowledgment a default? Well, not all tasks are **idempotent**, and Celery maintainers do not force developers to write tasks in such fashion. When using late acknowledgment, one has to make sure that a task can be safely run multiple times without corrupting the system state. In certain cases, it could be much more challenging to design a task this way.

Early acknowledgement has its good use cases too. Let's say you have a cleaning task that is being scheduled every 10 minutes or so. If you skip the current one, it might be wiser to just wait for the next run instead of occupying the queue (assuming the task will properly compensate for the skipped opportunity).

## Set timeouts

Workers might get stuck. For reasons both within and beyond your control. There might be a subtle bug in the library that you are using resulting in a deadlock. Maybe an API client that you are using is configured to retry forever, but the server has changed it's API. List of maybes might be quite long.

Setting a reasonable limit for task to execute will save you from occupying CPU cores for no reason and signalize the problem happening during the execution.

## Configure priorities if applicable

Chances are, not all tasks are of equal importance to your application. Whenever there is a temporary spike in the amount of work, some tasks in the queue can probably be moved to the bottom to allow workers to deal with the most critical workload first. Luckily, Celery supports priorities for this exact purpose. If you're using Redis as a broker, check this post I wrote on [configuring Celery task priorities with Redis](
{{< ref "posts/prioritizing-tasks-with-celery-and-redis" >}} ).

## Use separate queues with dedicated workers for critical tasks

Sometimes configuring priorities alone might not be sufficient to ensure sufficient level of reliability. In such cases, consider introducing dedicated workers for your critical tasks. A worker listening on a separate queue is the way to go for a lot of use cases, but you might also think of a more sophisticated [routing strategy](https://docs.celeryq.dev/en/latest/userguide/routing.html).

## Use custom exceptions

When using Celery's [retrying mechanism](https://docs.celeryq.dev/en/latest/userguide/tasks.html#retrying), one thing that should be noted is that the exception your task raises will be serialized and pushed to the queue alongside other task execution information. The problem arises when a particular exception is not serializable. That might happen with custom exceptions, especially the ones raised by some third-party library that you don't have control over. In that case the retrying will fail with a serialization error. A practice of using custom exceptions for Celery retries will save you from situations like that.

Instead of:

```py3
@app.task(autoretry_for=(ThirdPartyException,))
def my_task():
    do_something()
```

Prefer:

```py3
class RetriableException(Exception):
    pass


@app.task(autoretry_for=(RetriableException,))
def my_task():
    try:
        do_something()
    except ThirdPartyException:
        raise RetriableException
```

Note that you should not use `from` when raising your custom exceptions, otherwise it will lead to the same problem, because all the parent exceptions in the stack need to be serializable too. If you need some information from the third-party exception, consider logging it or manually extracting a string from it and passing it to your custom exception.
