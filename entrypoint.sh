#!/usr/bin/env bash
sed -i "s/\[INSTANCE\-ID\]/$BIGTABLE_INSTANCE/g" /usr/share/geoserver/webapps/geoserver/WEB-INF/classes/hbase-site.xml
sed -i "s/\[PROJECT\-ID\]/$BIGTABLE_PROJECT/g" /usr/share/geoserver/webapps/geoserver/WEB-INF/classes/hbase-site.xml
sh /usr/share/geoserver/bin/startup.sh
