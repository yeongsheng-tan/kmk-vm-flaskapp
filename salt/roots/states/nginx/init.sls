include:
  - yum.nginx

nginx:
  pkg.installed:
    - normalize: True
    - refresh: True
    - skip_verify: True
    - skip_suggestions: True

  service.running:
    - name: nginx
    - require:
      - pkg: nginx
