kmk-app-dotgit-dir:
  file.absent:
    - name: {{ pillar['kmk_app']['base_app_dir'] }}/.git
    - require:
        - git: kmk-flaskapp-git-clone

kmk-app-dotgitignore-file:
  file.absent:
    - name: {{ pillar['kmk_app']['base_app_dir'] }}/.gitignore
    - require:
        - git: kmk-flaskapp-git-clone
