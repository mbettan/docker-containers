FROM tomcat:7
MAINTAINER Antoine PLANTIN antoine.plantin@hp.com
ADD jasperreports-server-cp-6.0.1-bin.zip /tmp/jasperreports-server-cp-6.0.1-bin.zip
ENV JAVA_HOME /usr
RUN unzip /tmp/jasperreports-server-cp-6.0.1-bin.zip && \
    cd jasperreports-server-cp-6.0.1-bin/buildomatic && \
    cp sample_conf/postgresql_master.properties default_master.properties && \
    sed -i 's|appServerDir\ =\ C:\\\\Program\ Files\\\\Apache\ Software\ Foundation\\\\Tomcat\ 7.0|# appServerDir\ =\ C:\\\\Program\ Files\\\\Apache\ Software\ Foundation\\\\Tomcat\ 7.0|g' default_master.properties && \
    sed -i 's|#\ appServerDir\ =\ \/home\/devuser\/apache-tomcat-7.0.26|appServerDir\ =\ '$CATALINA_HOME'|g' default_master.properties && \
    sed -i 's|dbHost=localhost|dbHost='172.17.0.10'|g' default_master.properties && \
    ./js-install-ce.sh minimal && \
    echo "export JAVA_OPTS="$JAVA_OPTS -Xms1024m -Xmx2048m -XX:PermSize=32m"">>bin/setenv.sh && \
    echo "export JAVA_OPTS="$JAVA_OPTS -XX:MaxPermSize=512m -Xss2m"">>bin/setenv.sh && \
    echo "export JAVA_OPTS="$JAVA_OPTS -XX:+UseConcMarkSweepGC"">>bin/setenv.sh && \
    echo "export JAVA_OPTS="$JAVA_OPTS -XX:+CMSClassUnloadingEnabled"">>bin/setenv.sh && \
    chmod 755 bin/setenv.sh
EXPOSE 8080
CMD ["catalina.sh", "run"]
