include:
  - yum.git

install-git:
  pkg.installed:
    - name: git
    - require_in:
        - git: kmk-flaskapp-git-clone
