FROM python:3.12

EXPOSE 8080

ARG ENVIRONMENT

ENV PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1 \
    POETRY_CACHE_DIR="/var/cache/poetry"

RUN apt-get update \
    && apt-get --no-install-recommends install -y inotify-tools \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install poetry

RUN mkdir -p /var/cache/poetry && \
    mkdir -p /vol/app/src && \
    mkdir -p /vol/app/tests && \
    mkdir -p /vol/app/.ci_reports

WORKDIR /vol/app

COPY /poetry.lock /vol/app/poetry.lock
COPY /pyproject.toml /vol/app/pyproject.toml

RUN groupadd -r app && \
    useradd -r -g app app && \
    chown -R app:app /vol/app && \
    chown -R app:app /var/cache/poetry

USER app

RUN poetry install --without dev --no-interaction --no-ansi --no-root --no-directory

COPY /src /vol/app/src
COPY /tests /vol/app/tests

RUN poetry install --without dev --no-root --no-interaction --no-ansi

ENTRYPOINT ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]