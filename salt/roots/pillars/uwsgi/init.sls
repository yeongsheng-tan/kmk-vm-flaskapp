uwsgi:
  ini_file: /webapps/kmk/uwsgi.ini
  module: app
  callable: app
  uid: kmk
  gid: nginx
  num_processes: 4
  venv: /webapps/.virtualenvs/kmk_app
  socket_file: /tmp/kmk_app.sock
  chmod_socket: 660
  is_die_on_term: true
  is_master: true
  is_vacuum: true
  is_vhost: true
