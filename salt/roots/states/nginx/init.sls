include:
  - yum.nginx

nginx:
  pkg.installed:
    - normalize: True
    - refresh: True
    - skip_verify: True
    - skip_suggestions: True
    - require_in:
        - file: /usr/lib/systemd/system/nginx.service

  service.running:
    - name: nginx

/usr/lib/systemd/system/nginx.service:
  file.managed:
    - source: salt://nginx/templates/nginx.service
    - require_in:
        - service: nginx

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/templates/nginx.conf
    - require_in:
        - service: nginx

nginx-logrotate:
  file.managed:
    - name:   /etc/logrotate.d/nginx
    - source: salt://nginx/templates/logrotate.conf
    - template: jinja
    - defaults: {{ pillar['nginx'] }}
