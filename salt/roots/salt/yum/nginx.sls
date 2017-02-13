nginx-yum-repo:
  pkgrepo.managed:
    - humanname: nginx repo
    - baseurl: http://nginx.org/packages/centos/$releasever/$basearch/
    - gpgcheck: 0
    - enabled: 1
