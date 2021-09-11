Title: Why Flask will teach you more about software engineering than Django
Slug: why-flask-will-teach-you-more-than-django
Date: 2021-09-11
Tags: python, flask, django
Summary: If you used only Django for your web projects and never tried Flask, you may be losing a lot of learning opportunities
Status: published

## Intro

I started my journey in web development with Django. That was the first framework that I’ve learned right after familiarizing myself with a bit of Python programming language. Shortly, I was able to write a couple of web applications with it. I was so fascinated by the fact that I can build a full-featured website in a couple of days or sometimes hours dependning on project complexity. I remember trying Flask several times for some pet projects of mine. Sometimes I managed to build something really simple with it but as long as things started to get complex, I gave up pretty quickly. Django was so much easier to work with for me as a beginning software engineer. When I was stuck with something in Django, almost every time there will be a detailed answer on stackoverflow. Things were not that easy with Flask. So I played with Flask here and there but never built anything serious with it.

## Second try

After several years of working with Django both at my job and for personal projects, I finally decided to give Flask another try and dive deep into it. The main motivation for me this time was my desire to learn SQLAlchemy ORM. I was already a middle engineer at that point, knowing something about servers, databases and software design. I started a toy project and surprisingly managed to finish it in a couple of days. Moreover, I totally fell in love with the process of building it. Flask gave me complete freedom over the application design and I utilized that opportunity to create an app that would perfectly suit my every need. I used Flask for almost every personal project since then and I learned a lot while doing them. I thought about my experience with Django and I finally came to a conclusion that choosing Flask at the very beginning of my career would be a much more beneficial decision in the long run.

Let's walk over some points where I personally think Flask compared to Django can be more enlightening especially to entry-level engineers.

## Implementing things from scratch

Django comes batteries-included. It has features for almost any use case that an average web project will ever come up with. You can build a working authentication system in Django in no time and knowing nothing about things that are going on under the hood. Django will take care of hashing passwords, storing them in database, verifying them later when a user tries to sign in, managing user sessions, and a lot more.

Flask in comparison is a very lightweight out of the box. It does not give you much. You are on your own. You can utilize some third-party library to solve some common tasks, or you can build things from scratch. If you choose the latter option, this is where the actual learning lies. You will spend much more time thinking about what your code is really doing by starting from zero.

## Design philosophy

Django is an absolutely beautiful piece of software. There are so many brilliant design decisions in Django's codebase that made working with a framework a piece of cake. But there is a downside to that when it comes to learning things. Django makes eveything Django-way. Even though framework design is really great, you cannot fully appreciate it unless you know deeply what problems Django developers were trying to solve and what alternative design could be chosen.

In order to fully understand a good framework design, you have to know what bad design is. And where do you such bad design? The best way is to write it yourself. Nobody learned to design good computer programs right from the start. If you ever played chess, you know that you start as a pretty bad player. But the more embarassing games you play, the more you think about your moves, analyze your mistakes and next time come up with a much better strategy. I beleve the same principle applies to software engineering. You have to write a lot of bad programs in order to master skill. Flask forces no opinions about your codebase and is the perfect tool for web applications design.
