---
title: Portfolio Tracker
date: 2024-02-19
---

![Preview](/portfolio-tracker.png)

This is a hobby project that I have been working on for a while. It is a simple portfolio tracker that allows users to keep track of their investments. It only supports equities from the S&P 500 index for the moment. Financial data is fetched from the remote API using a cron job and stored in the local SQLite database.

Users can manage their portfolio holdings, view stock price charts, and see basic performance metrics.

Technologies used:

- Python
- Django
- SQLite
- HTMX (for reactivity without much JavaScript)
- Tailwind CSS

Try it out here:
[https://portfolio.olzhasar.com](https://portfolio.olzhasar.com/)
