nginx:
  systemd_unit_file: /usr/lib/systemd/system/nginx.service
  conf_file: /etc/nginx/nginx.conf
  log_dir: /var/log/nginx
  posix_user: nginx
  posix_group: nginx
  posix_uid: 500
  posix_gid: 500
