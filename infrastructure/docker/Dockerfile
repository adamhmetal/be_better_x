FROM python:3.12

EXPOSE 8080

RUN apt-get update && apt-get install -y coreutils git inotify-tools libsodium23

RUN groupadd -r app && \
    useradd -r -g app app && \
    mkdir -p /vol/app

WORKDIR /vol/app

COPY /poetry.lock /vol/app/poetry.lock
COPY /pyproject.toml /vol/app/pyproject.toml

RUN pip3 install poetry && poetry install

COPY / /vol/app

USER app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]