tomcat:
    version: 6
    security: 'no'
    connector:
      port: 8443
      protocol: 'org.apache.coyote.http11.Http11Protocol'
      connectionTimeout: 20000
      URIEncoding: 'UTF-8'
      redirectPort: 8443
      maxHttpHeaderSize: 8192
      maxThreads: 150
      minSpareThreads: 25
      enableLookups: 'false'
      disableUploadTimeout: 'true'
      acceptCount: 100
      scheme: https
      secure: 'true'
      SSLEnabled: 'true'
      clientAuth: 'false'
      sslProtocol: TLS
      keystoreFile: '/path/to/keystoreFile'
      keystorePass: 'somerandomtext'
    sites:
        example.com:
          appBase: ../webapps/myapp
          path: ''
          docBase: '/var/lib/tomcat/webapps/myapp'
          alias: 'example.com'
          unpackWARs: "true"
          autoDeploy: "true"
          reloadable: "true"
          debug: 0
        example.net:
          appBase: ../webapps/myapp2
          path: ''
          docBase: '/var/lib/tomcat7/webapps/myapp2'
          alias: 'example.net'
          unpackWARs: "true"
          autoDeploy: "true"
          reloadable: "true"
          debug: 0
    manager:
         user: saltuser
         passwd: RfgpE2iQwD
java:
    home: '/usr/lib/jvm/jre-1.6.0-openjdk.x86_64/'
    Xmx: 3G # TODO: Need to do a calculation based on the available memory on the machine.
    MaxPermSize: 256m
    UseConcMarkSweepGC: '-XX:+UseConcMarkSweepGC'
    CMSIncrementalMode: '-XX:+CMSIncrementalMode'
limit:
    soft: 64000
    hard: 64000
