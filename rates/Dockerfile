FROM python:3.12.3-slim as build
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	build-essential libpq-dev gcc 

WORKDIR /usr/app

RUN python -m venv /usr/app/venv
ENV PATH="/usr/app/venv/bin:$PATH"

RUN pip install --upgrade pip

RUN pip install -U gunicorn

COPY requirements.txt .
RUN pip install -Ur requirements.txt

FROM python:3.12.3-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	build-essential libpq-dev 

RUN mkdir /usr/app
WORKDIR /usr/app

COPY  --from=build /usr/app/venv ./venv
COPY rates.py wsgi.py config.py entrypoint.sh ./

RUN chmod +x entrypoint.sh

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PATH="/usr/app/venv/bin:$PATH"

CMD ["/usr/app/entrypoint.sh"]