#!/usr/bin/env bash
sed -i 's/\[INSTANCE\-ID\]/geomesa/g' /usr/share/geoserver/webapps/geoserver/WEB-INF/classes/hbase-site.xml
sed -i 's/\[PROJECT\-ID\]/cdot-daisy-internal/g' /usr/share/geoserver/webapps/geoserver/WEB-INF/classes/hbase-site.xml
sh /usr/share/geoserver/bin/startup.sh
