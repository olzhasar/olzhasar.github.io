---
title: Use autospeccing for your mocks in Python
date: 2024-02-05

tags:
  - python
  - tdd
---

Mocks are a powerful concept in testing. They are one of several types of [test doubles](https://martinfowler.com/bliki/TestDouble.html), which are objects that can be used in place of real objects in your tests. Mocks are used to isolate the code under test from the rest of the system, and to verify that the code under test interacts with its dependencies correctly. However, if not used properly, mocks can lead to false positives in your tests. One common pitfall is that mocks can be too permissive, allowing you to call methods that don't exist on the real object. This can lead to tests that pass even when the code under test is broken.

Consider the following Python code:

**foo.py**

```py3
import requests

def main():
    result = fetch_url()
    return "Fetched: " + result

def fetch_url(url: str) -> str:
    response = requests.get()
    return response.text
```

Let's say we would like to test our main function and we want to mock the piece of logic making external requests

**test_foo.py**

```py3
from unittest import mock
from foo import main

def test_main():
    with mock.patch("foo.fetch_url") as mock_fetch:
        mock_fetch.return_value = "Some response"

        assert main() == "Fetched: Some response"
```

The above test passes without any issues. However, our code is broken cause we did not provide a required positional argument `url` in a call to the `fetch_url` function. The reason it happened is because mocks in Python [create all attributes and methods as you access them](https://docs.python.org/3/library/unittest.mock.html#quick-guide) by default. Is there a way to prevent this? Yes, by providing a specification to the mock object. The class constructor accepts a `spec` argument which can be used to create specification from any existing object or a list of strings (used as list of arguments to create). However, python also provides a convenient [autospeccing mechanism](https://docs.python.org/3/library/unittest.mock.html#autospeccing) to automatically create spec based on api of the object being mocked. Let's see the updated test:

```py3
def test_main():
    with mock.patch("foo.fetch_url", autospec=True) as mock_fetch:
        mock_fetch.return_value = "Some response"

        assert main() == "Fetched: Some response"
```

The result of the above test is now:

```sh
FAILED test_foo.py::test_main - TypeError: missing a required argument: 'url'
```
