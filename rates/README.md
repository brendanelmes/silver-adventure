# Rates API
A simple Flask application to display values from a Postgres database.

## Local setup
Navigate to `/application/rates`

Create a Python virtual environment to isolate the install of dependencies:

```bash
python3 -m venv venv
```

Activate the venv:

```bash
source venv/bin/activate
```

> For more information about Virtual Environments, see [this RealPython article.](https://realpython.com/python-virtual-environments-a-primer/)

Install the packages:

```bash
pip install -U gunicorn
pip install -Ur requirements.txt
```

Start the server:

```bash
gunicorn -b :3000 wsgi
```

To debug:

```bash
gunicorn --log-level debug -b :3000 wsgi
```
