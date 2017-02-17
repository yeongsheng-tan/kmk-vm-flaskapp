uwsgi:
  systemd_unit_file: /etc/systemd/system/kmk-uwsgi.service
  multi_user_system_service_file: /etc/systemd/system/multi-user.target.wants/kmk-uwsgi.service
  log_dir: /var/log/kmk
  uid: kmk
  gid: nginx
  app_root: /webapps/kmk
  venv_bin_dir: /webapps/.virtualenvs/kmk_app/bin
  uwsgi_bin_path: "PATH=/webapps/.virtualenvs/kmk_app/bin"
  ini_file: /webapps/kmk/uwsgi.ini
