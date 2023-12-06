FROM python:3.12

EXPOSE 8080

RUN apt-get update && apt-get --no-install-recommends install -y \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r app && \
    useradd -r -g app app && \
    mkdir -p /vol/app/src && \
    mkdir -p /vol/app/tests

WORKDIR /vol/app

COPY /poetry.lock /vol/app/poetry.lock
COPY /pyproject.toml /vol/app/pyproject.toml

RUN pip3 install poetry && poetry install

COPY /src /vol/app/src
COPY /tests /vol/app/tests

USER app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]