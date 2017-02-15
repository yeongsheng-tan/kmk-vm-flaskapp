git:
  pkg.installed:
    - normalize: True
    - refresh: True
    - skip_verify: True
    - skip_suggestions: True
    - require_in:
        - git: kmk-flaskapp-git-clone
