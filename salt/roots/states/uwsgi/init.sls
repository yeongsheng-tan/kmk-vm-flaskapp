uwsgi:
  pip.installed:
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - use_wheel: True
    - bin_env: {{ pillar['kmk_app']['base_venv_dir'] }}
    - require:
        - pip: pip
