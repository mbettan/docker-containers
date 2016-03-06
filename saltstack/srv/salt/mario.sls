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


/usr/share/nginx/html/mario.png:
 file:
  - managed
  - source: salt://nginx/src/mario.png

/usr/share/nginx/html/index.html:
  file:
    - managed
    - source: salt://nginx/mario.html.jinja
    - template: jinja
