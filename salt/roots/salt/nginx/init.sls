include:
  - yum.nginx

install-nginx:
  pkg.installed:
    - name: nginx
      
  service.running:
    - name: nginx
    - require:
      - pkg: install-nginx
