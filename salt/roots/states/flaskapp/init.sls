venv-dir:
  file.directory:
    - name: {{ pillar['kmk_app']['base_venv_dir'] }}
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - group: {{ pillar['kmk_app']['posix_group'] }}
    - makedirs: True
    - recurse:
        - user
        - group
    - require:
        - pip: virtualenvwrapper

venv-setup:
  virtualenv.managed: 
    - name: {{ pillar['kmk_app']['base_venv_dir'] }}
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - require:
        - file: venv-dir

kmk-flaskapp-git-clone:
  git.latest:
    - name: {{ pillar['kmk_app']['git_url'] }}
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - target: {{ pillar['kmk_app']['base_app_dir'] }}
    - rev: {{ pillar['kmk_app']['git_branch'] }}
    - branch: {{ pillar['kmk_app']['git_branch'] }}
    - force_reset: True
    - force_clone: True

flaskapp-requirements:
  pip.installed:
    - name: flaskapp-pip
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - use_wheel: True
    - requirements: {{ pillar['kmk_app']['base_app_dir'] }}/requirements.txt
    - bin_env: {{ pillar['kmk_app']['base_venv_dir'] }}
    - require:
        - git: kmk-flaskapp-git-clone 
        - pip: pip
