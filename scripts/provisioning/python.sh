#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-vagrant}

export HOME=/home/${SSH_USER}

echo "==> Installing Pyenv build tools"
# From https://github.com/yyuu/pyenv/wiki/Common-build-problems
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm

echo "==> Preparing Pyenv configuration."
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> /home/${SSH_USER}/.bashrc
echo 'eval "$(pyenv init -)"' >> /home/${SSH_USER}/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' /home/${SSH_USER}/.bashrc

su ${SSH_USER} <<EOF
echo "==> Installing Pyenv"
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
source ~/.bashrc
env PATH=/home/vagrant/.pyenv/bin:$PATH pyenv install 2.7.9
env PATH=/home/vagrant/.pyenv/bin:$PATH pyenv install 3.4.3
env PATH=/home/vagrant/.pyenv/bin:$PATH pyenv global 2.7.9
EOF

chown -R ${SSH_USER}:${SSH_USER} /home/${SSH_USER}
