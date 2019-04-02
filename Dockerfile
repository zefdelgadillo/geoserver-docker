FROM openjdk:8-jre
MAINTAINER zef.delgadillo@gmail.com

ENV GEOSERVER_HOME="/usr/share/geoserver"
ENV GEOSERVER_DATA_DIR="/usr/share/geoserver/data_dir"
ENV GEOSERVER_VERSION="2.14.2"
ENV GEOMESA_VERSION="2.2.1"

RUN wget http://sourceforge.net/projects/geoserver/files/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-bin.zip \
    && unzip geoserver-$GEOSERVER_VERSION-bin.zip \
    && mv geoserver-$GEOSERVER_VERSION /usr/share
WORKDIR /usr/share
RUN ln -s geoserver-$GEOSERVER_VERSION geoserver

WORKDIR /opt
RUN wget "https://github.com/locationtech/geomesa/releases/download/geomesa_2.11-$GEOMESA_VERSION/geomesa-bigtable_2.11-$GEOMESA_VERSION-bin.tar.gz"
RUN tar xvf geomesa-bigtable_2.11-$GEOMESA_VERSION-bin.tar.gz
RUN ln -s geomesa-bigtable_2.11-$GEOMESA_VERSION geomesa-bigtable
WORKDIR /opt/geomesa-bigtable_2.11-$GEOMESA_VERSION
RUN tar xvf dist/gs-plugins/geomesa-bigtable-gs-plugin_2.11-$GEOMESA_VERSION-install.tar.gz -C /usr/share/geoserver/webapps/geoserver/WEB-INF/lib
RUN bin/install-hadoop-hbase.sh
RUN cp lib/hadoop-annotations-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hadoop-auth-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hadoop-common-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/protobuf-java-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/commons-io-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-server-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/commons-configuration-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-annotations-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-hadoop-compat-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-hadoop2-compat-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-client-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-common-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-prefix-tree-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-procedure-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib \
    && cp lib/hbase-protocol-*.jar /usr/share/geoserver/webapps/geoserver/WEB-INF/lib

# Stealth steps
COPY apps/stealth-webapp-3.2.0-20181019.232537-10.war /opt/
RUN mkdir stealth && unzip -d stealth /opt/stealth-webapp-3.2.0-20181019.232537-10.war
RUN cp -r stealth/ /usr/share/geoserver/webapps/

# Configuration steps
RUN cp conf/hbase-site.xml /usr/share/geoserver/webapps/geoserver/WEB-INF/classes
COPY config/web.xml /usr/share/geoserver-2.14.2/webapps/geoserver/WEB-INF/

WORKDIR /usr/share/geoserver
RUN mkdir -p /usr/share/tmp
COPY entrypoint.sh /usr/share/tmp 
RUN chmod +x /usr/share/tmp/entrypoint.sh

VOLUME /usr/share/geoserver/data_dir
CMD ["/usr/share/tmp/entrypoint.sh"]
