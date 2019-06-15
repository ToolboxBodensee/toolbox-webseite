import ast
import io
import re

from setuptools import setup, find_packages

with io.open('README.md', 'rt', encoding="utf8") as f:
    readme = f.read()

_description_re = re.compile(r'description\s+=\s+(?P<description>.*)')

with open('lektor_indentfix.py', 'rb') as f:
    description = str(ast.literal_eval(_description_re.search(
        f.read().decode('utf-8')).group(1)))

setup(
    author='maxbachmann',
    author_email='kontakt@maxbachmann.de',
    description=description,
    keywords='Lektor plugin',
    license='Jinja2-License',
    long_description=readme,
    long_description_content_type='text/markdown',
    name='lektor-indentfix',
    packages=find_packages(),
    py_modules=['lektor_indentfix'],
    url='https://github.com/pallets/jinja',
    version='1.0',
    classifiers=[
        'Framework :: Lektor',
        'Environment :: Plugins',
    ],
    entry_points={
        'lektor.plugins': [
            'indentfix = lektor_indentfix:IndentfixPlugin',
        ]
    }
)
