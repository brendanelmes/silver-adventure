FROM python:3.13.0a3-slim as build
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
	build-essential gcc 

WORKDIR /usr/app
RUN python -m venv /usr/app/venv
ENV PATH="/usr/app/venv/bin:$PATH"

RUN pip install -U gunicorn

COPY requirements.txt .
RUN pip install -Ur requirements.txt

FROM python:3.13.0a3-slim

RUN groupadd -g 999 python && \
    useradd -r -u 999 -g python python

RUN mkdir /usr/app && chown python:python /usr/app
WORKDIR /usr/app

COPY --chown=python:python --from=build /usr/app/venv ./venv
COPY --chown=python:python rates.py wsgi.py ./

USER 999

ENV PATH="/usr/app/venv/bin:$PATH"
CMD ["gunicorn", "-b", "0.0.0.0:5000", "wsgi"]

# Less secure - initial test to make sure container ran correctly
# FROM python:3.13.0a3-slim
# WORKDIR /usr/app
# COPY requirements.txt .
# RUN pip install -r requirements.txt
# EXPOSE 5000
# COPY . /usr/app
# CMD ["gunicorn", "-b", "0.0.0.0:5000", "wsgi"]
