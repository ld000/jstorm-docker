#!/bin/bash

set -e

# Generate the config only if it doesn't exist
CONFIG="$JSTORM_HOME/conf/storm.yaml"
if [ ! -f "$CONFIG" ]; then
    cat << EOF > "$CONFIG"
storm.zookeeper.servers: [zookeeper]
nimbus.seeds: [nimbus]
ui.clusters:
     - {
         name: "jstorm.share",
         zkRoot: "/jstorm",
         zkServers:
             [zookeeper],
         zkPort: 2181,
       }
EOF
fi

mkdir ~/.jstorm
cp -f $JSTORM_HOME/conf/storm.yaml ~/.jstorm/

./startup.sh
tail -f ../logs/catalina.out

exec "$@"
