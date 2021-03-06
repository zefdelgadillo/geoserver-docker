#!/usr/bin/env bash
sed -i "s/\[INSTANCE\-ID\]/$BIGTABLE_INSTANCE/g" /usr/share/geoserver/webapps/geoserver/WEB-INF/classes/hbase-site.xml
sed -i "s/\[PROJECT\-ID\]/$BIGTABLE_PROJECT/g" /usr/share/geoserver/webapps/geoserver/WEB-INF/classes/hbase-site.xml

sed -i "s/\[INSTANCE\-ID\]/$BIGTABLE_INSTANCE/g" /opt/geomesa-bigtable/conf/hbase-site.xml
sed -i "s/\[PROJECT\-ID\]/$BIGTABLE_PROJECT/g"  /opt/geomesa-bigtable/conf/hbase-site.xml

# see https://geomesa.atlassian.net/browse/GEOMESA-2363
sed -i "s/hbase1_2/hbase1_3/g" /usr/share/geoserver/webapps/geoserver/WEB-INF/classes/hbase-site.xml
sed -i "s/hbase1_2/hbase1_3/g" /opt/geomesa-bigtable/conf/hbase-site.xml

sh /usr/share/geoserver/bin/startup.sh
