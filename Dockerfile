FROM anapsix/alpine-java:latest

ENV TOMCAT_VERSION_MAJOR 8
ENV TOMCAT_VERSION_FULL 8.0.33
ENV CATALINA_HOME /opt/tomcat
ENV LOG4J_VERSION 1.2.17
ENV LOG4J_URL http://www.us.apache.org/dist/logging/log4j/$LOG4J_VERSION/log4j-$LOG4J_VERSION.tar.gz

RUN apk add --update curl tar &&\
  curl -kLsS https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION_FULL}/bin/apache-tomcat-${TOMCAT_VERSION_FULL}.tar.gz \
    | gunzip -c - | tar -xf - -C /opt && \
  ln -s /opt/apache-tomcat-${TOMCAT_VERSION_FULL} /opt/tomcat && \
  rm -rf /opt/tomcat/webapps/* && rm -f ${CATALINA_HOME}/bin/*.bat ${CATALINA_HOME}/bin/*.tar.gz && \
  curl -fSL "$LOG4J_URL" -o log4j.tar.gz && \
  tar -xf log4j.tar.gz && \
  cp apache-log4j-$LOG4J_VERSION/log4j-*.jar ${CATALINA_HOME}/lib/ && \
  rm -rf apache-log4j-$LOG4J_VERSION 

COPY log4j.xml $CATALINA_HOME/lib/log4j.xml

EXPOSE 8080

CMD ${CATALINA_HOME}/bin/catalina.sh run
