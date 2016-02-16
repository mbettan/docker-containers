iptables:
 service.dead:
  - name: iptables
  - enable: False
  

  
nginx:
  pkg:
    - installed
  service.running:
    - watch:
      - pkg: nginx

/usr/share/nginx/html/index.html:
  file:
    - managed
    - source: salt://nginx/index.html.jinja
    - template: jinja
