---
title: Good software engineering habits
date: 2025-01-22

tags:
  - programming

draft: true
---

I recently stumbled upon a question on HackerNews where a person asked for "great programmer habits". I shared whatever was on top of my mind as a comment, but I then decided to take time and write a full blog post to reveal them in more detail. By no means I consider myself a preeminent software engineer with the best set of habits. However, I developed quite a few of them that proved themselves effective for me and will hopefully be useful for someone else.

## Make your software observable

Observability is what, among others things, distinguishes a good piece of software from a bad one. Chances are, your code will break no matter how good you wrote it in the first place. Save yourself tons of future troubleshooting time by utilizing good observability tools.

### Logging
One of the easiest and most effective ways to make software observable is by logging important program execution parts. Make sure you don't overuse it, log important stuff only. It takes some amount of practice to get good at understanding what's worth logging and what is not.

Make sure you have a way to analyze logs after your application (and the correspondent container or server) crashes. That usually means implementing some collecting logic and reliable persistence layer for your logs (e.g. Loki, Logstash, Graylog, Cloudwatch, etc.).

## Don't abstract prematurely

## Prefer readability over performance

## Teach your software to recover from a malformed state

## Consistency is more important than perfection

## Write meaningful commit messages

## Question the status quo

## Prefer boring tech

## Write good tests

## Don't fall in love with your code
