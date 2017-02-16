uwsgi:
  pip.installed:
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - use_wheel: True
    - bin_env: {{ pillar['kmk_app']['base_venv_dir'] }}
    - require:
        - pip: pip

uwsgi-ini:
  file.managed:
    - name: {{ pillar['uwsgi']['ini_file'] }} 
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - group: {{ pillar['nginx']['posix_group'] }}
    - uid: {{ pillar['kmk_app']['posix_uid'] }}
    - gid: {{ pillar['nginx']['posix_gid'] }}
    - mode: 644
    - source: salt://uwsgi/templates/uwsgi.ini
    - template: jinja
    - defaults: {{ pillar['uwsgi'] }}
    - skip_verify: True
