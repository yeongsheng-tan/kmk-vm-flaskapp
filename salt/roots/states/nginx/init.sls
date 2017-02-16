include:
  - yum.nginx

nginx:
  pkg.installed:
    - normalize: True
    - refresh: True
    - skip_verify: True
    - skip_suggestions: True
    - require_in:
        - pkg: python2-build-deps
        - pip: uwsgi
        - file: uwsgi-ini
        - service: nginx

  service.running:
    - name: nginx
