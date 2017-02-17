# kmk-vm-flaskapp
Vagrant CentOS 7 (SELinux disabled) virtualbox, salt-stack provisioned, for nginx uwsgi flask python app
#### Github repo: https://github.com/yeongsheng-tan/kmk-vm-flaskapp

## Ensure vagrant-landrush plugin is installed
1. `vagrant plugin install landrush`

* Used as a mini-dns server to host dns entry devops.kmklabs.dev to IP 10.10.10.20 

## Up and running
1. `vagrant up`

* Utilises master-less saltstack minion for provisioning and configuring the Guest OS (CentOS 7.3 with SELinux disabled)
* Salt Minion configuration is stored in salt/minion and synchronised into Guest OS and used to trigger minion salt high-state
* App is cloned/installed into /webapps/kmk using Unix user 'kmk' belonging to 'nginx' Unix UserGroup
* Utilises uwsgi to host and run python flaskapp via virtualenvwrapper as user 'kmk' (Installed as Systemd service unit kmk-uwsgi)
* Nginx provides the web server that listens on port 80 and bridges/serves request on location / to uwsgi socket running on /run/kmk/uwsgi.sock
* /run/kmk/uwsgi.sock is kmk:nginx owned with file mode 660 and forwards/returns requests/response to/from nginx to flaskapp
* Systemd service init files for both nginx and uwsgi is configured to Restart=always for auto-service recovery on unexpected failures
* Guest OS System Time is set to UTC
* uwsgi app logs are written to /var/log/kmk/uwsgi.log and is logrotated daily (with 30 backlog gzipped copies)
* nginx access and error logs are written to /var/log/nginx/access.log and /var/log/nginx/error.log and is logrotated daily (with 30 backlog gzipped copies)
* Guest OS packages are updated to the latest on initial vagrant up before any salt states are activated
* .git directory and .gitignore file is sanitised post git clone from https://github.com/KMK-ONLINE/devops-coding-challenge.git
