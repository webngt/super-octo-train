#!/bin/bash

download=/usr/local/share/microk8s

mkdir -p $download

snap download --target-directory=$download core

core_assert=$(ls $download/core_*.assert)
core_snap=$(ls $download/core_*.snap)

snap download --target-directory=$download microk8s

microk8s_assert=$(ls $download/microk8s_*.assert)
microk8s_snap=$(ls $download/microk8s_*.snap)

cat > /usr/local/bin/launch.sh <<EOF
#!/bin/bash

snap ack $core_assert
snap install $core_snap

snap ack $microk8s_assert
snap install $microk8s_snap --classic
EOF

chmod 755 /usr/local/bin/launch.sh

mkdir /usr/local/share/tmpfiles
