#!/bin/sh

cat > /etc/rc.local <<EOF
#!/bin/bash

apparmor_parser --replace /var/lib/snapd/apparmor/profiles/snap.microk8s.*
exit 0
EOF

chmod +x /etc/rc.local

snap download --target-directory=/root microk8s

cat > /usr/local/bin/launch.sh <<EOF
#!/bin/bash

snap ack /root/microk8s_1910.assert
snap install /root/microk8s_1910.snap
EOF

chmod +x /usr/local/bin/launch.sh
