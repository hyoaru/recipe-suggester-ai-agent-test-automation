FROM python:3.12-bookworm

WORKDIR /tests

RUN apt-get update && apt-get install -y \
  curl \
  bash \
  git \
  nodejs \
  npm \
  libcups2 \
  libnss3 \  
  libnspr4 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libatspi2.0-0 \
  libxdamage1 \ 
  libxkbcommon0 \
  libasound2     

COPY pyproject.toml uv.lock .python-version ./

RUN pip install uv && uv sync
RUN uv pip freeze > requirements.txt
RUN pip install -r requirements.txt
RUN rfbrowser init 

CMD ["bash", "run_tests.sh"]
