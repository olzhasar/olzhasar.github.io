---
title: "Unlocking the power of asyncio Semaphore"
date: 2023-05-31T10:10:15+06:00

tags:
  - asyncio
  - python
---

When building asynchronous applications, oftentimes you need to limit the number of simultaneous connections to a shared resource. It can be your internal server, or an API that has usage limits.

`asyncio` library provides a dedicated synchronization primitive [`Semaphore`](https://docs.python.org/3/library/asyncio-sync.html#asyncio.Semaphore) created exactly for this purpose. However, let's first try to solve this problem without using it, in order to fully appreciate the value of this mechanism.

We can limit the number of simultaneous connections by using a `counter` variable that will be incremented whenever we start making a request and decremented when we receive our response. Let's look at the example code:

```python
import asyncio

import aiohttp

URL = "https://google.com/"

connections = 0
connections_limit = 3


async def make_request(session: aiohttp.ClientSession):
    global connections
    while connections >= connections_limit:
        await asyncio.sleep(0.1)

    connections += 1

    async with session.get(URL) as response:
        await response.text()

    connections -= 1


async def main():
    async with aiohttp.ClientSession() as session:
        await asyncio.gather(*(make_request(session) for _ in range(10)))


asyncio.run(main())
```

You may have guessed that this code has a problem - it allows possible race conditions when multiple `coroutines` try to concurrently mutate our `connections` variable. This can lead to inaccurate connections counting. We can fix that by introducing a [`Lock`](https://docs.python.org/3/library/asyncio-sync.html#lock):

```python
import asyncio

import aiohttp

URL = "https://google.com/"

connections = 0
connections_limit = 3
connections_lock = asyncio.Lock()


async def make_request(session: aiohttp.ClientSession):
    global connections
    while connections >= connections_limit:
        await asyncio.sleep(0.1)

    async with connections_lock:
        connections += 1

    async with session.get(URL) as response:
        await response.text()

    async with connections_lock:
        connections -= 1


async def main():
    async with aiohttp.ClientSession() as session:
        await asyncio.gather(*(make_request(session) for _ in range(10)))


asyncio.run(main())
```

Now the `connections_lock` ensures that only a single `coroutine` can mutate the `connections` variable at any moment in time. Even though this example now works, the code is far from being beautiful. It can however be simplified significantly by using the above mentioned [`Semaphore`](https://docs.python.org/3/library/asyncio-sync.html#asyncio.Semaphore) primitive:

```python
import asyncio

import aiohttp

URL = "https://google.com/"

connections = 0
sem = asyncio.Semaphore(3)


async def make_request(session: aiohttp.ClientSession):
    async with sem:
        async with session.get(URL) as response:
            await response.text()


async def main():
    async with aiohttp.ClientSession() as session:
        await asyncio.gather(*(make_request(session) for _ in range(10)))


asyncio.run(main())

```

This code does pretty much the same job as the example with the Lock. `asyncio.Semaphore` automatically blocks the execution of the `coroutine` if the number of currently acquired locks that were not released exceeds the specified capacity.
