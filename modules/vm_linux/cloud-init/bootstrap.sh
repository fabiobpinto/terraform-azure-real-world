#!/bin/bash
set -e
exec > /var/log/bootstrap.log 2>&1

echo "BOOTSTRAP STARTED $(date)" > /var/lib/bootstrap.done

source /etc/os-release

# ---- Pacotes básicos + timezone ----
if command -v apt >/dev/null; then
  apt-get update
  apt-get install -y python3
elif command -v yum >/dev/null; then
  yum install -y python3
fi

timedatectl set-timezone America/Sao_Paulo

# ---- Usuário Ansible ----
USER="useransible"
PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDX5s/UxV3mZi+TFVuyDSn1gkMNm1ei/t6WjKk2SatSIRZmRT5GddGbIJuAYuN02Qfzpcr6hJCrJUB8G5e62404WE5yuasNlmBPhXYYM+6y7ahDzb1F+607626bkuydvTu6hGVJQ6QLf+i9RaKo/KxHKFCkSQINTOudlGtqH6ayCAnmGRe1DNBE10qky2eBKFmBRLDOlHs/HktvImfWVo1FaA0PhaszD78ymJb2VWrnyQo/idZWsHUI0Pm3PEtuR2k88v0166V3QhW3gsjZg5oNQs6AjimzmnC3imMBSsIsxT1CBc1+HSSLVuyCFAV6smIydPy+YMh3P8hI0O4QkM+dH98QY77nlF/o1NxnbqCItYt3h6kPqAG6wHmuYd+4cShwNwNzonUGFa2z7wyYB14B1Oepn94xwNxelvWVXJrN2Uu1CTgS9rRNPfcfWnkgLOifVNlUFTzDitbikkMz0blbLega0DXybGzNqRLQwz4skaMIAeruSa08uOCt2levqhFscGr5WQglyoUSTfnx5HaHBS/3XO47Hmz2EgSEBWL8FM50utQMiFA5+2sLDSUjGWKAOPKQ3T1MibO7PKrYEe692b4FnLUOWM+uAw5WrIMrzg+C9X76hIvftDeaVUp/5plFGYIb66IW15FJsuX4PX6n3dI1Uk+MYF8gF+spqFlAHw== useransible"

if ! id "$USER" &>/dev/null; then
  useradd -m -s /bin/bash "$USER"
fi

mkdir -p /home/$USER/.ssh
grep -qxF "$PUB_KEY" /home/$USER/.ssh/authorized_keys 2>/dev/null || \
  echo "$PUB_KEY" >> /home/$USER/.ssh/authorized_keys

chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER/.ssh

echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER
chmod 440 /etc/sudoers.d/$USER

echo "BOOTSTRAP FINISHED $(date)" >> /var/lib/bootstrap.done
