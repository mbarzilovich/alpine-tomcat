FROM anapsix/alpine-java:latest

ENV TOMCAT_VERSION_MAJOR 8
ENV TOMCAT_VERSION_FULL 8.0.32
ENV CATALINA_HOME /opt/tomcat

RUN apk add --update curl &&\
  curl -kLsS https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
  ln -s /opt/apache-tomcat-${TOMCAT_VERSION_FULL} /opt/tomcat && \
  rm -rf /opt/tomcat/webapps/* && rm -f ${CATALINA_HOME}/bin/*.bat ${CATALINA_HOME}/bin/*.tar.gz


EXPOSE 8080

CMD ${CATALINA_HOME}/bin/catalina.sh run
