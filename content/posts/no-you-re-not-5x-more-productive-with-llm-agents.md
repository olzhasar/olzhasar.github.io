---
title: "No, you're not 5x more productive with LLM agents"
date: 2026-05-19T01:36:18+07:00
draft: true
---

It's 2026 and it's been a while since we started to witness one of the largest tectonic shifts in how the software is being built. Everyone and their dogs are now burning tokens for living, spawning myriads of LLM agents that take vague product requirements and turn them into beautifully crafted pieces of software (assuming they were asked to make no mistakes, of course). Before going any further, let me quickly clarify that I'm not an opponent of using LLM agents for programming. At this point, it's hard to deny that they do simplify routine tasks, increase velocity, and make the life of a regular software engineer easier. With that being said, I constantly hear folks claiming that they are now 3x, 5x or even 10x more productive when writing code. I don't believe these numbers. Here's why.

## Software Engineer's Productivity

In order to reason about the productivity impact of LLM agents, first it's wise to agree on what are we putting in the term "productivity" in the context of producing software. According to a broad economic definition, productivity *is a measure of efficiency that compares the quantity of goods and services produced (output) to the amount of resources used (input)*. To put it even simpler, productivity is the output that we get divided by the input we put into the process.

Sounds straightforward enough, but what is precisely the output and the input in our case? The latter is the easy part, as we are usually talking about development costs as the time software engineers spend working, or human hours. However, it's not as simple with the former.

What is the output that we should be measuring? A lot of teams desperately try to optimize their processes for the output, but they rarely stop to question what is it precisely that they are optimizing for. Is it the number of lines of codes that were typed (or generated) or PRs merged? The number of features shipped? If you know at least a tiny bit about the real software engineering process, you'd probably agree that counting [the lines of code produced](https://www.youtube.com/shorts/jq2xVr1O1UA) is not the best KPI to employ. The raw number of features goes in the same category as this measure doesn't account for the qualitative features of the software being produced. Okay, what about the correctness of the software? Maintainability of the codebase, aka the easiness of making changes and debugging the system? The number of bugs fixed or issues resolved? These are just the examples, in reality there's a lot more, but you get the idea. There's a whole lot of things that together form an output and measuring it can be quite challenging. I'm convinced that when LLM agents' assistance is being used responsibly, the productivity gains are real but they are far from those shiny numbers people are bragging with.
