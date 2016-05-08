FROM osixia/openldap:1.1.2

MAINTAINER Michaël Bettan <michael.bettan@hpe.com>

ENV LDAP_ORGANISATION "Hewlett-Packard"
ENV LDAP_DOMAIN "example.com"
ENV LDAP_ADMIN_PASSWORD "admin"

ADD ./ldap.ldif /tmp/ldap.ldif
ADD ./startup.sh /container/service/slapd/startup.sh
RUN chmod +x /container/service/slapd/startup.sh

# Expose default ldap and ldaps ports
EXPOSE 389 636
