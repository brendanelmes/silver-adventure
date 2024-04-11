## Connecting the rates app to the database

Initial attempt to deploy original flask code resulted in the following error:

```
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:11 Traceback (most recent call last):
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:11     worker.init_process()
2024-04-11 00:11:11     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:11     self.load_wsgi()
2024-04-11 00:11:11     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:11     self.wsgi = self.app.wsgi()
2024-04-11 00:11:11                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:11     self.callable = self.load()
2024-04-11 00:11:11                     ~~~~~~~~~^^
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:11     return self.load_wsgiapp()
2024-04-11 00:11:11            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:11     return util.import_app(self.app_uri)
2024-04-11 00:11:11            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:11     mod = importlib.import_module(module)
2024-04-11 00:11:11           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:11   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:11     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:11            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:11   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:11   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:11   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:11   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:11   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:11   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:11   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:11     from rates import create_app
2024-04-11 00:11:11   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:11     import psycopg2
2024-04-11 00:11:11   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:11     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:11     ...<10 lines>...
2024-04-11 00:11:11     )
2024-04-11 00:11:11 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:11 [2024-04-10 23:11:11 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:12 Traceback (most recent call last):
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:12     worker.init_process()
2024-04-11 00:11:12     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:12     self.load_wsgi()
2024-04-11 00:11:12     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:12     self.wsgi = self.app.wsgi()
2024-04-11 00:11:12                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:12     self.callable = self.load()
2024-04-11 00:11:12                     ~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:12     return self.load_wsgiapp()
2024-04-11 00:11:12            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:12     return util.import_app(self.app_uri)
2024-04-11 00:11:12            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:12     mod = importlib.import_module(module)
2024-04-11 00:11:12           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:12   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:12     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:12            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:12   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:12   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:12     from rates import create_app
2024-04-11 00:11:12   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:12     import psycopg2
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:12     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:12     ...<10 lines>...
2024-04-11 00:11:12     )
2024-04-11 00:11:12 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:12 Traceback (most recent call last):
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:12     worker.init_process()
2024-04-11 00:11:12     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:12     self.load_wsgi()
2024-04-11 00:11:12     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:12     self.wsgi = self.app.wsgi()
2024-04-11 00:11:12                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:12     self.callable = self.load()
2024-04-11 00:11:12                     ~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:12     return self.load_wsgiapp()
2024-04-11 00:11:12            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:12     return util.import_app(self.app_uri)
2024-04-11 00:11:12            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:12     mod = importlib.import_module(module)
2024-04-11 00:11:12           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:12   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:12     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:12            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:12   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:12   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:12   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:12     from rates import create_app
2024-04-11 00:11:12   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:12     import psycopg2
2024-04-11 00:11:12   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:12     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:12     ...<10 lines>...
2024-04-11 00:11:12     )
2024-04-11 00:11:12 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:12 [2024-04-10 23:11:12 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:13 Traceback (most recent call last):
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:13     worker.init_process()
2024-04-11 00:11:13     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:13     self.load_wsgi()
2024-04-11 00:11:13     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:13     self.wsgi = self.app.wsgi()
2024-04-11 00:11:13                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:13     self.callable = self.load()
2024-04-11 00:11:13                     ~~~~~~~~~^^
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:13     return self.load_wsgiapp()
2024-04-11 00:11:13            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:13     return util.import_app(self.app_uri)
2024-04-11 00:11:13            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:13     mod = importlib.import_module(module)
2024-04-11 00:11:13           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:13   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:13     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:13            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:13   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:13   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:13   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:13   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:13   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:13   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:13   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:13     from rates import create_app
2024-04-11 00:11:13   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:13     import psycopg2
2024-04-11 00:11:13   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:13     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:13     ...<10 lines>...
2024-04-11 00:11:13     )
2024-04-11 00:11:13 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:13 [2024-04-10 23:11:13 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:14 Traceback (most recent call last):
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:14     worker.init_process()
2024-04-11 00:11:14     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:14     self.load_wsgi()
2024-04-11 00:11:14     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:14     self.wsgi = self.app.wsgi()
2024-04-11 00:11:14                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:14     self.callable = self.load()
2024-04-11 00:11:14                     ~~~~~~~~~^^
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:14     return self.load_wsgiapp()
2024-04-11 00:11:14            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:14     return util.import_app(self.app_uri)
2024-04-11 00:11:14            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:14     mod = importlib.import_module(module)
2024-04-11 00:11:14           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:14   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:14     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:14            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:14   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:14   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:14   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:14   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:14   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:14   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:14   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:14     from rates import create_app
2024-04-11 00:11:14   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:14     import psycopg2
2024-04-11 00:11:14   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:14     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:14     ...<10 lines>...
2024-04-11 00:11:14     )
2024-04-11 00:11:14 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:14 [2024-04-10 23:11:14 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:16 Traceback (most recent call last):
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:16     worker.init_process()
2024-04-11 00:11:16     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:16     self.load_wsgi()
2024-04-11 00:11:16     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:16     self.wsgi = self.app.wsgi()
2024-04-11 00:11:16                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:16     self.callable = self.load()
2024-04-11 00:11:16                     ~~~~~~~~~^^
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:16     return self.load_wsgiapp()
2024-04-11 00:11:16            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:16     return util.import_app(self.app_uri)
2024-04-11 00:11:16            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:16     mod = importlib.import_module(module)
2024-04-11 00:11:16           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:16   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:16     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:16            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:16   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:16   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:16   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:16   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:16   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:16   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:16   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:16     from rates import create_app
2024-04-11 00:11:16   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:16     import psycopg2
2024-04-11 00:11:16   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:16     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:16     ...<10 lines>...
2024-04-11 00:11:16     )
2024-04-11 00:11:16 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:16 [2024-04-10 23:11:16 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:20 Traceback (most recent call last):
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:20     worker.init_process()
2024-04-11 00:11:20     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:20     self.load_wsgi()
2024-04-11 00:11:20     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:20     self.wsgi = self.app.wsgi()
2024-04-11 00:11:20                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:20     self.callable = self.load()
2024-04-11 00:11:20                     ~~~~~~~~~^^
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:20     return self.load_wsgiapp()
2024-04-11 00:11:20            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:20     return util.import_app(self.app_uri)
2024-04-11 00:11:20            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:20     mod = importlib.import_module(module)
2024-04-11 00:11:20           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:20   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:20     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:20            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:20   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:20   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:20   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:20   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:20   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:20   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:20   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:20     from rates import create_app
2024-04-11 00:11:20   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:20     import psycopg2
2024-04-11 00:11:20   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:20     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:20     ...<10 lines>...
2024-04-11 00:11:20     )
2024-04-11 00:11:20 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:20 [2024-04-10 23:11:20 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [7] [INFO] Booting worker with pid: 7
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [7] [ERROR] Exception in worker process
2024-04-11 00:11:27 Traceback (most recent call last):
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:27     worker.init_process()
2024-04-11 00:11:27     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:27     self.load_wsgi()
2024-04-11 00:11:27     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:27     self.wsgi = self.app.wsgi()
2024-04-11 00:11:27                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:27     self.callable = self.load()
2024-04-11 00:11:27                     ~~~~~~~~~^^
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:27     return self.load_wsgiapp()
2024-04-11 00:11:27            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:27     return util.import_app(self.app_uri)
2024-04-11 00:11:27            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:27     mod = importlib.import_module(module)
2024-04-11 00:11:27           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:27   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:27     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:27            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:27   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:27   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:27   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:27   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:27   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:27   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:27   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:27     from rates import create_app
2024-04-11 00:11:27   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:27     import psycopg2
2024-04-11 00:11:27   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:27     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:27     ...<10 lines>...
2024-04-11 00:11:27     )
2024-04-11 00:11:27 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [7] [INFO] Worker exiting (pid: 7)
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [1] [ERROR] Worker (pid:7) exited with code 3
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:27 [2024-04-10 23:11:27 +0000] [1] [ERROR] Reason: Worker failed to boot.
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [1] [INFO] Starting gunicorn 21.2.0
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [1] [INFO] Listening at: http://0.0.0.0:5000 (1)
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [1] [INFO] Using worker: sync
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [6] [INFO] Booting worker with pid: 6
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [6] [ERROR] Exception in worker process
2024-04-11 00:11:40 Traceback (most recent call last):
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/arbiter.py", line 609, in spawn_worker
2024-04-11 00:11:40     worker.init_process()
2024-04-11 00:11:40     ~~~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 134, in init_process
2024-04-11 00:11:40     self.load_wsgi()
2024-04-11 00:11:40     ~~~~~~~~~~~~~~^^
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/workers/base.py", line 146, in load_wsgi
2024-04-11 00:11:40     self.wsgi = self.app.wsgi()
2024-04-11 00:11:40                 ~~~~~~~~~~~~~^^
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/base.py", line 67, in wsgi
2024-04-11 00:11:40     self.callable = self.load()
2024-04-11 00:11:40                     ~~~~~~~~~^^
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 58, in load
2024-04-11 00:11:40     return self.load_wsgiapp()
2024-04-11 00:11:40            ~~~~~~~~~~~~~~~~~^^
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/app/wsgiapp.py", line 48, in load_wsgiapp
2024-04-11 00:11:40     return util.import_app(self.app_uri)
2024-04-11 00:11:40            ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/gunicorn/util.py", line 371, in import_app
2024-04-11 00:11:40     mod = importlib.import_module(module)
2024-04-11 00:11:40           ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
2024-04-11 00:11:40   File "/usr/local/lib/python3.13/importlib/__init__.py", line 88, in import_module
2024-04-11 00:11:40     return _bootstrap._gcd_import(name[level:], package, level)
2024-04-11 00:11:40            ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
2024-04-11 00:11:40   File "<frozen importlib._bootstrap>", line 1387, in _gcd_import
2024-04-11 00:11:40   File "<frozen importlib._bootstrap>", line 1360, in _find_and_load
2024-04-11 00:11:40   File "<frozen importlib._bootstrap>", line 1331, in _find_and_load_unlocked
2024-04-11 00:11:40   File "<frozen importlib._bootstrap>", line 935, in _load_unlocked
2024-04-11 00:11:40   File "<frozen importlib._bootstrap_external>", line 1012, in exec_module
2024-04-11 00:11:40   File "<frozen importlib._bootstrap>", line 488, in _call_with_frames_removed
2024-04-11 00:11:40   File "/usr/app/wsgi.py", line 1, in <module>
2024-04-11 00:11:40     from rates import create_app
2024-04-11 00:11:40   File "/usr/app/rates.py", line 1, in <module>
2024-04-11 00:11:40     import psycopg2
2024-04-11 00:11:40   File "/usr/app/venv/lib/python3.13/site-packages/psycopg2/__init__.py", line 51, in <module>
2024-04-11 00:11:40     from psycopg2._psycopg import (                     # noqa
2024-04-11 00:11:40     ...<10 lines>...
2024-04-11 00:11:40     )
2024-04-11 00:11:40 ImportError: libpq.so.5: cannot open shared object file: No such file or directory
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [6] [INFO] Worker exiting (pid: 6)
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [1] [ERROR] Worker (pid:6) exited with code 3
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [1] [ERROR] Shutting down: Master
2024-04-11 00:11:40 [2024-04-10 23:11:40 +0000] [1] [ERROR] Reason: Worker failed to boot.

```


Resolved issues:

- config.py referring to localhost changed to host **postgres**
- Dockerfile base image python 3.12 due to versioning issues with psycopg2
- Added PGPASSWORD environment variable to Dockerfile (will move to compose later)