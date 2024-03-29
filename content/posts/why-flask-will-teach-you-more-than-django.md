---
title: Why Flask will teach you more about software engineering than Django
date: 2021-09-11

aliases:
  - /why-flask-will-teach-you-more-than-django/

tags:
  - flask
  - django
  - python
---

## Intro

I started my journey in back-end development with Django. That was the first framework that I’ve learned right after familiarizing myself with a bit of Python programming language. Pretty soon I was able to write simple web applications with it. I was so fascinated by the fact that I can build a full-featured website in a couple of days or sometimes hours depending on project complexity. I remember trying Flask for a couple of pet projects. Sometimes I managed to build something simple with it but as soon as complexity of the application started to grow, I would give up sooner or later. Django was so much easier to work with for me as a beginning software engineer. When I was stuck with something in Django, almost every time there would be a detailed answer on `stackoverflow`. It was much trickier to find solutions for issues that I faced using Flask. As a result, I played with Flask here and there but never built anything serious with it.

## Second try

After several years of working with Django both at my job and for personal projects, I finally decided to give Flask another try and dive deep into it. The main motivation for me this time was my desire to learn `SQLAlchemy` ORM. I was already a middle engineer at that point, knowing something about servers, databases and software design. I started a toy project and surprisingly managed to finish it in a couple of days. Moreover, I totally fell in love with the process of building it. Flask gave me complete freedom over the application design and I utilized that opportunity to create an app that would perfectly suit my every need. I used Flask for almost every personal project since then and I learned a lot while doing them. I thought about my experience with Django and I finally came to a conclusion that choosing Flask at the beginning of my career would be a much more beneficial decision in the long run.

Let's walk over some points where I think Flask compared to Django can be more enlightening especially to entry-level engineers.

## Implementing things from scratch

Django comes batteries-included. It has features for almost any use case that an average web project will ever come up with. You can build a working authentication system in Django in no time and knowing nothing about things that are going on under the hood. Django will take care of hashing passwords, storing them in database, verifying them later when a user tries to sign in, managing user sessions, and a lot more.

Flask in comparison is extremely lightweight out of the box. It does not give you much. You are on your own. You can utilize some third-party library to solve some common tasks, or you can build things from scratch. If you choose the latter option, this is where the actual learning lies. You will spend much more time thinking about what your code is actually doing by starting from zero.

## Design philosophy

Django is an absolutely beautiful piece of software. There are so many brilliant design decisions in Django's codebase that made working with the framework a piece of cake. But there is a downside to that beauty when it comes to learning things because almost all design decisions are already made for you. Django expects almost everything to be done Django-way. You obviously can ditch all the built-in abstractions and write your own from scratch, but this will likely make your project significantly deviate from Django's philosophy. With a complex long-term project, you can come to a point when there are no reasons left to use Django at all.

Flask, contrastingly, does not force you to do things a certain way. Once again, you have a complete freedom, and you can do pretty much anything you want. That also means that you will probably make bad decisions in the beginning of your journey, but that's where you will learn a lot. If you ever played chess, you probably started as a pretty bad player. But the more bad moves you make and games you lose, the more you analyze your mistakes and correct your strategy, which results in your progress. I believe the same principle applies to software engineering. Nobody learned to produce perfect computer programs right from the start. You absolutely need to make a lot of mistakes and analyze outcomes to truly master your software design skills. And Flask is the perfect tool to make such mistakes and progress as a software engineer.

## `SQLAlchemy` vs Django ORM

Even though Flask is not coupled with any ORM solution out of the box, developers typically choose [`SQLAlchemy`](https://www.sqlalchemy.org/) to work with relational databases in their Flask applications. Django comes with its own Object-relational mapping tool which is oftentimes called Django ORM. These two ORM solutions follow quite different data access patterns: `SQLAlchemy` uses [Data mapper pattern](https://en.wikipedia.org/wiki/Data_mapper_pattern) and Django ORM uses [Active Record Pattern](https://en.wikipedia.org/wiki/Active_record_pattern). What it means is that Django maps every python object to a particular row in a database whereas in `SQLAlchemy` database operations and python objects are separated. Consider the following example of querying and deleting a row in a database:

Django:

```py3
user = User.objects.get(id=1)
user.delete()
```

`SQLAlchemy`:

```py3
user = session.query(User).get(1)
session.delete(user)
session.commit()
```

Django allows you to call obj.delete() method directly on the model instance because that instance is mapped to a specific row in the database. `SQLAlchemy` expects you to use session for making final queries. The latter approach can actually be safer in many situations because you always instruct the database explicitly whether to perform a particular query or not. To illustrate this point, consider the following example in Django:

```py3
users = user.objects.all()
for user in users:
    user.name
```

In Django ORM, queries are lazy by default which means their execution is postponed to the last moment when you will actually do something with the data. In this example, the query will be performed only on the second line of code when the iteration starts. Now let's say you have the following code:

```py3
def some_func(users):
    for user in users:
        print(user.name)
```

We cannot say for sure when the query will actually be performed because we don't know was this QuerySet of users evaluated earlier or not. This can lead to undesired side effects especially during development of large software projects.

I've worked with both object-relational mappers in a bunch of projects and my personal opinion is that `SQLAlchemy` is safer and also makes you think more in terms of actual SQL queries that the database will produce compared to Django. Forming that mindset in my opinion is extremely beneficial for any entry-level backend engineer.

## Summary

In conclusion, Django is undoubtedly a great web framework that will make your life easier especially if you have tight deadlines and want to iterate as quickly as possible. But it comes with a lot of magic hidden inside that prevents developers from understanding the whole picture. If you are not yet a highly experienced engineer and lack some knowledge, I would strongly recommend you to try Flask at least for your side projects. It will probably take more of your working time if you are just starting out with Flask, but that will be an important investment in your backend development skills. On the other hand, if you are an experienced engineer but want to drop the boundaries and implement your brilliant design decisions in a complete freedom, you will also profit a lot by choosing Flask as your framework.
