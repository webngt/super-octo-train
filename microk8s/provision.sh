#!/bin/sh

cat > /etc/rc.local <<EOF
#!/bin/bash

apparmor_parser --replace /var/lib/snapd/apparmor/profiles/snap.microk8s.*
exit 0
EOF

chmod +x /etc/rc.local

snap download --target-directory=/root core
snap download --target-directory=/root microk8s

cat > /usr/local/bin/launch.sh <<EOF
#!/bin/bash

snap ack /root/core_10583.assert
snap install /root/core_10583.snap

snap ack /root/microk8s_1910.assert
snap install /root/microk8s_1910.snap --classic
EOF

chmod +x /usr/local/bin/launch.sh
