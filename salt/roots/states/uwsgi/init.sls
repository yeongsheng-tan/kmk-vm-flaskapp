uwsgi:
  pip.installed:
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - upgrade: True
    - bin_env: {{ pillar['kmk_app']['base_venv_dir'] }}
    - require_in:
        - service: kmk-uwsgi

uwsgi-ini:
  file.managed:
    - name: {{ pillar['uwsgi']['ini_file'] }}
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - group: {{ pillar['kmk_app']['posix_group'] }}
    - mode: 644
    - source: salt://uwsgi/templates/uwsgi.ini
    - template: jinja
    - defaults: {{ pillar['kmk_app'] }}
    - require_in:
        - service: kmk-uwsgi

/etc/systemd/system/kmk-uwsgi.service:
  file.managed:
    - source: salt://uwsgi/templates/kmk-uwsgi.service
    - require_in:
        - file: /etc/systemd/system/multi-user.target.wants/kmk-uwsgi.service

/etc/systemd/system/multi-user.target.wants/kmk-uwsgi.service:
  file.symlink:
    - target: /etc/systemd/system/kmk-uwsgi.service
    - require_in:
        - service: kmk-uwsgi

kmk-uwsgi-log-dir:
  file.directory:
    - name: {{ pillar['uwsgi']['log_dir'] }}
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - group: {{ pillar['nginx']['posix_group'] }}
    - require:
        - pkg: nginx

kmk-uwsgi-logrotate:
  file.managed:
    - name:   /etc/logrotate.d/kmk-uwsgi
    - source: salt://uwsgi/templates/logrotate.conf
    - template: jinja
    - defaults: {{ pillar['uwsgi'] }}

kmk-uwsgi:
  service.running: []
