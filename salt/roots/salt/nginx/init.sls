include:
  - yum.nginx

install-nginx:
  pkg.installed:
    - name: nginx
      
  service.running:
    - name: nginx
    - require:
      - pkg: install-nginx


# nginx-vhost-default:
#   file.managed:
#     - name: /etc/nginx/sites-available/default
#     - source: salt://nginx/vhosts/default.nginx
#     - require:
#       - pkg: nginx

# nginx-vhost-default-enabled:
#   file.symlink:
#     - name: /etc/nginx/sites-enabled/default
#     - target: /etc/nginx/sites-available/default
#     - require:
#       - pkg: nginx


# /var/www/default/index.html:
#   file.managed:
#     - source: salt://nginx/www/index.html

# /var/www/default/404.html:
#   file.managed:
#     - source: salt://nginx/www/404.html
