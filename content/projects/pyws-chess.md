---
title: pyws-chess
date: 2024-10-22
---

I have built a real-time online chess game as a fun weekend hacking project. The game was built in Python with a bit of JavaScript on the front-end.


Check out the live demo here:
[https://chess.olzhasar.com/](https://chess.olzhasar.com/)


The game has a simple matching mechanism - the players are being put in a queue and matched based on the FIFO principle.

The server was built using the `FastAPI` framework. The real-time communication is powered by `websockets` and the code utilizes `asyncio` for concurrency.

Source code:
[https://github.com/olzhasar/pyws-chess](https://github.com/olzhasar/pyws-chess)
