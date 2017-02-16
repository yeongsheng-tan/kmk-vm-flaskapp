yum-update-all:
  cmd.run:
    - name: yum clean all && yum update -y
    - cwd: /
    - require_in:
        - user: kmk-app-posix-user
        # - pkg: yum-plugin-versionlock

# yum-plugin-versionlock:
#   pkg.installed:
#     - normalize: True
#     - refresh: True
#     - skip_verify: True
#     - skip_suggestions: True
          
kmk-app-posix-user:
  user.present:
    - name: {{ pillar['kmk_app']['posix_user'] }}
    - uid: {{ pillar['kmk_app']['posix_uid'] }}
    - gid: {{ pillar['kmk_app']['posix_gid'] }}
    - groups:
        - {{ pillar['kmk_app']['posix_group'] }}
    - require_in:
        - file: base_dir
        - git: kmk-flaskapp-git-clone
        - pip: flaskapp-requirements

kmk-app-posix-group:
  group.present:
    - name: {{ pillar['kmk_app']['posix_group'] }}
    - gid: {{ pillar['kmk_app']['posix_gid'] }}
    - require_in:
        user: kmk-app-posix-user

python2-build-deps:
  pkg.installed:
    - normalize: True
    - refresh: True
    - skip_verify: True
    - skip_suggestions: True
    - pkgs:
        - gcc
        - python-devel
        - python2-pip
    - require_in:
        - pip: virtualenvwrapper
    # - require:
    #     - pkg: yum-plugin-versionlock

virtualenvwrapper:
  pip.installed:
    - use_wheel: True

pip:
  pip.installed:
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - use_wheel: True
    - upgrade: True
    - bin_env: {{ pillar['kmk_app']['base_venv_dir'] }}
    - require:
        - virtualenv: venv-setup

base_dir:
  file.directory:
    - name: {{ pillar['kmk_app']['base_dir'] }}
    - user: {{ pillar['kmk_app']['posix_user'] }}
    - group: {{ pillar['kmk_app']['posix_group'] }}
    - require_in:
        - file: venv-dir
        - git: kmk-flaskapp-git-clone
