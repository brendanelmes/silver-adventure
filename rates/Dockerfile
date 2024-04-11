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

RUN groupadd -g 999 python && \
    useradd -r -u 999 -g python python

RUN mkdir /usr/app && chown python:python /usr/app
WORKDIR /usr/app

COPY --chown=python:python --from=build /usr/app/venv ./venv
COPY --chown=python:python rates.py wsgi.py config.py ./

USER 999

ENV PGPASSWORD=postgres

ENV PYTHONUNBUFFERED=1 \
    PATH="/usr/app/venv/bin:$PATH"
CMD ["gunicorn", "--log-level", "debug", "-b", "0.0.0.0:5000", "wsgi"]