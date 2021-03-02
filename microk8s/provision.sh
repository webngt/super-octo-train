#!/bin/bash

cat > /etc/rc.local <<EOF
#!/bin/bash

apparmor_parser --replace /var/lib/snapd/apparmor/profiles/snap.microk8s.*
exit 0
EOF

chmod 755 /etc/rc.local

download=/usr/local/share/microk8s

mkdir -p $download

snap download --target-directory=$download core
snap download --target-directory=$download microk8s

cat > /usr/local/bin/launch.sh <<EOF
#!/bin/bash

snap ack $download/core_10583.assert
snap install $download/core_10583.snap

snap ack $download/microk8s_1910.assert
snap install $download/microk8s_1910.snap --classic
EOF

chmod 755 /usr/local/bin/launch.sh
