uwsgi:
  pip.installed:
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - use_wheel: True
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

# /run/kmk:
#   file.directory:
#     - user: {{ pillar['kmk_app']['posix_user'] }}
#     - group: {{ pillar['nginx']['posix_group'] }}
#     - makedirs: True
#     - recurse:
#         - user
#         - group
#     - require:
#        - pkg: nginx

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

kmk-uwsgi:
  service.running:
    - require_in:
        - service: nginx
