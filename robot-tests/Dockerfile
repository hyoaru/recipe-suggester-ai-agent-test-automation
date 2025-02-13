FROM python:3.12-slim

WORKDIR /tests

RUN apt-get update && apt-get install -y \
  curl \
  bash \
  git \
  nodejs \
  npm \
  fonts-liberation \
  libatk-bridge2.0-0 \
  libatspi2.0-0 \
  libxkbcommon0 \
  libnss3 \
  libatk1.0-0 \
  libx11-xcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libasound2 \
  libpango-1.0-0 \
  libcups2 \
  && rm -rf /var/lib/apt/lists/*
  
COPY pyproject.toml uv.lock .python-version ./

RUN pip install uv && uv sync
RUN uv run rfbrowser init

COPY . .

RUN chmod +x ./run_tests.sh

CMD ["bash", "run_tests.sh"]