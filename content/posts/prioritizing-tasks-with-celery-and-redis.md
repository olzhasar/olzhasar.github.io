---
title: "Prioritizing Tasks With Celery and Redis"
date: 2024-09-01T21:32:41+05:00
draft: false
---

Task prioritization can be an effective technique to ensure the most critical tasks are processed in time. There are other ways to achieve this, like using dedicated workers, but prioritizing is arguably the simplest, and in many cases, the most cost-effective approach. Celery supports task prioritization natively, but it works differently depending on the broker you use. If you use RabbitMQ, for example, prioritizing will be handled on the broker side, meaning that the broker will decide which message to deliver first. However, RabbitMQ might be an overkill for a lot of projects, and Redis is often preferred due to its simplicity. It turns out, one can still prioritize tasks with Redis, but it works in a slightly different fashion.

## How task prioritization works in Celery with Redis as a broker

Redis, being essentially a key-value store, doesn't support task priorities out of the box. However, `celery` emulates broker-side priorities by using separate queues for different priority levels. When you send a task with a certain priority level, it will be placed in a corresponding queue. The worker will then decide which queue to consume tasks from based on the queue priority. As celery docs state, this will never be as good as broker-side prioritization, but in my experience, it works well enough.

## Setting up task priorities with Celery and Redis

Firstly, you need to set the `queue_order_strategy` in the celery configuration:

```python
app.conf.broker_transport_options = {
    'queue_order_strategy': 'priority',
}
```

Or, if you are configuring `celery` from `django` settings:

```python
CELERY_BROKER_TRANSPORT_OPTIONS = {
    'queue_order_strategy': 'priority',
}
```

`celery` creates 4 queues by default, while the priority levels are 0-9. I personally find it confusing, so I prefer to explicitly define the queues:

```python
app.conf.broker_transport_options = {
    'priority_steps': list(range(10)),
    'sep': ':',
    'queue_order_strategy': 'priority',
}
```

We now have 10 separate queues for each priority level (0-9).

**IMPORTANT**: Lower values correspond to higher priority levels, so tasks with 0 priority value will be processed first.

Last thing, we need to make sure we don't prefetch a lot of tasks at once, otherwise, prioritization will not make much sense. Imagine your worker prefetched 10 tasks in advance, and something critical comes up. You will have to wait for existing (probably less important) tasks to get finished before you can proceed with the critical one. There is a `worker_prefetch_multiplier` setting responsible for this behavior. The value defaults to 4, to spend less time fetching, but if we want robust prioritization, value of 1 will be best:

```python
app.conf.worker_prefetch_multiplier = 1
```

That's it! We now have task prioritization set up with Celery and Redis.

## Task prioritization in practice

Priorities can be set when defining a task:

```python
@app.task(priority=0)
def critical_task():
    pass

@app.task(priority=4)
def regular_task():
    pass

@app.task(priority=9)
def not_so_important_task():
    pass
```

You can also override the priority when sending a task:

```python
critical_task.apply_async(args=['foo'], kwargs={'bar': 1}, priority=5)
```
