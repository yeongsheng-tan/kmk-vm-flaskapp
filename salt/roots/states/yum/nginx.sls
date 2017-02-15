nginx-repo:
  pkgrepo.managed:
    - humanname: nginx repo
    - baseurl: http://nginx.org/packages/centos/$releasever/$basearch/
    - refresh_db: True
    - gpgcheck: 0
    - disabled: 0
