from re import DOTALL

from pytest_bdd import given, parsers, scenario, then, when


@given('service is working by command "python /vol/src/frup/run.py"')
def step_impl():
    ...


@when('I send "GET" request to "/status"')
def step_impl():
    ...


@then('I expect staus code "200"')
def step_impl():
    ...


# @then(parsers.parse("I expect response containing json:\n{content}"), target_fixture="text")
@then(parsers.re(r"I expect response containing json:\n?(?P<content>.*)", flags=DOTALL), target_fixture="multiline")
def step_impl(content):

    ...
