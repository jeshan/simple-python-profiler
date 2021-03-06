FROM python:3.7-alpine

WORKDIR /app

RUN pip install pipenv
COPY Pipfile Pipfile.lock ./
RUN pipenv install --system

COPY pyproject.toml README.md ./
COPY simple_python_profiler simple_python_profiler


ENV FLIT_ROOT_INSTALL=1
RUN flit install

RUN rm -rf simple_python_profiler

COPY simple_python_profiler/tests.py ./

RUN python -m simple_python_profiler tests.py
