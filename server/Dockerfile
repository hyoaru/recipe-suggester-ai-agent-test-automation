FROM python:3.13-alpine

WORKDIR /app

COPY pyproject.toml poetry.lock .

RUN pip install --no-cache-dir poetry
RUN poetry install

COPY . .

CMD [ "poetry", "run", "fastapi", "run", "main.py", "--host", "0.0.0.0", "--port", "8000" ]
