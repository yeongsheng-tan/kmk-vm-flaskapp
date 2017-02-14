python2-build-deps:
  pkg.installed:
    - pkgs:
        - gcc
        - python-devel
        - python2-pip

/webapps:
  file.directory:
    - user: vagrant
    - group: vagrant
    - require_in:
        - git: kmk-flaskapp-git-clone

venv-directory:
  file.directory:
    - name: /webapps/.virtualenvs/kmk/
    - user: vagrant
    - group: vagrant
    - makedirs: True
    - recurse:
        - user
        - group
    - require:
        - file: /webapps

venv-setup:
  virtualenv.managed: 
    - name: /webapps/.virtualenvs/kmk/
    - user: vagrant
    - require:
        - pip: virtualenvwrapper
        - file: venv-directory

kmk-flaskapp-git-clone:
  git.latest:
    - name: https://github.com/KMK-ONLINE/devops-coding-challenge.git
    - rev: master
    - user: vagrant
    - target: /webapps/kmk

flaskapp-requirements:
  pip.installed:
    - name: kmk-flaskapp-pip
    - user: vagrant
    - use_wheel: True
    - requirements: /webapps/kmk/requirements.txt
    - bin_env: /webapps/.virtualenvs/kmk/
    - require:
        - virtualenv: venv-setup
        - git: kmk-flaskapp-git-clone 

virtualenvwrapper:
  pip.installed:
    - use_wheel: True
    - require:
        - pkg: python2-build-deps
          
pip:
  pip.installed:
    - user: vagrant
    - use_wheel: True
    - upgrade: True
    - bin_env: /webapps/.virtualenvs/kmk/
    - require:
        - virtualenv: venv-setup
    - require_in:
        - pip: flaskapp-requirements

uwsgi:
  pip.installed:
    - user: vagrant
    - use_wheel: True
    - bin_env: /webapps/.virtualenvs/kmk/
    - require:
        - virtualenv: venv-setup
        - git: kmk-flaskapp-git-clone 
