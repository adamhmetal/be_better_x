# content of test_publish_article.py
import glob

from functional.steps import *
from pytest_bdd import scenarios

for f in glob.glob('**/*.feature', root_dir='tests/functional/features/', recursive=True):
    scenarios(f)
