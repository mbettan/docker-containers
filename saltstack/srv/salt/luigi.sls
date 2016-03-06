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

/usr/share/nginx/html/luigi.png:
 file:
  - managed
  - source: salt://nginx/src/luigi.png

/usr/share/nginx/html/index.html:
  file:
    - managed
    - source: salt://nginx/luigi.html.jinja
    - template: jinja
