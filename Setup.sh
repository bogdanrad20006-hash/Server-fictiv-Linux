#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Ca sa functioneze scriptul trebuie rulat cu sudo !"
  exit
fi

# 1. Crearea grupurilor si GID
groupadd -g 1100 sysadmin
groupadd -g 1200 devops
groupadd -g 1300 dev_team
groupadd -g 1400 design_team
groupadd -g 1500 management
groupadd -g 1600 techsoft_staff

# 2. Creare utilizatori cu UID specific si a grupurilor din care fac parte
useradd -m -u 1100 -g sysadmin -G devops,techsoft_staff -s /bin/bash admin
useradd -m -u 1200 -g devops -G techsoft_staff -s /bin/bash elena
useradd -m -u 1300 -g dev_team -G techsoft_staff -s /bin/bash alice
useradd -m -u 1301 -g dev_team -G techsoft_staff -s /bin/bash bob
useradd -m -u 1400 -g design_team -G techsoft_staff -s /bin/bash carol
useradd -m -u 1500 -g management -G techsoft_staff -s /bin/bash diana

#parole (Techsoft@2025)
echo "admin:Techsoft@2025" | chpasswd
echo "elena:Techsoft@2025" | chpasswd
echo "alice:Techsoft@2025" | chpasswd
echo "bob:Techsoft@2025" | chpasswd
echo "carol:Techsoft@2025" | chpasswd
echo "diana:Techsoft@2025" | chpasswd


chage -d 0 admin
chage -d 0 elena
chage -d 0 alice
chage -d 0 bob
chage -d 0 carol
chage -d 0 diana

chage -M 90 -W 7 alice
chage -M 90 -W 7 bob
chage -M 90 -W 7 carol
chage -M 90 -W 7 diana

#Crearea de directoare
mkdir -p /srv/techsoft/{dev/{src,database},design,management/{reports,confidential},devops/{scripts,configs},shared,logs}

# Creare fișiere de test
touch /srv/techsoft/dev/src/app.py
touch /srv/techsoft/dev/database/schema.sql
touch /srv/techsoft/devops/scripts/deploy.sh
touch /srv/techsoft/devops/scripts/backup.sh
touch /srv/techsoft/devops/configs/nginx.conf
touch /srv/techsoft/management/reports/q1_2025.pdf
touch /srv/techsoft/management/confidential/salarii.xlsx
touch /srv/techsoft/shared/readme.txt

#owners
chown root:sysadmin /srv/techsoft/
chown admin:dev_team /srv/techsoft/dev/
chown root:sysadmin /srv/techsoft/logs/
chown admin:dev_team /srv/techsoft/dev/src/
chown admin:dev_team /srv/techsoft/dev/database/
chown admin:management /srv/techsoft/management/
chown admin:management /srv/techsoft/management/reports/
chown admin:design_team /srv/techsoft/design/
chown diana:management /srv/techsoft/management/confidential/
chown elena:devops /srv/techsoft/devops/
chown elena:devops /srv/techsoft/devops/scripts/
chown elena:devops /srv/techsoft/devops/configs/
chown admin:techsoft_staff /srv/techsoft/shared/

chown alice:dev_team /srv/techsoft/dev/src/app.py && chmod 664 /srv/techsoft/dev/src/app.py
chown diana:management /srv/techsoft/management/confidential/salarii.xlsx && chmod 600 /srv/techsoft/management/confidential/salarii.xlsx
chown admin:techsoft_staff /srv/techsoft/shared/readme.txt && chmod 664 /srv/techsoft/shared/readme.txt
chown elena:devops /srv/techsoft/devops/scripts/deploy.sh
chmod 4750 /srv/techsoft/devops/scripts/deploy.sh

#restrictiile
chmod 2750 /srv/techsoft/
chmod 2770 /srv/techsoft/dev/
chmod 2770 /srv/techsoft/dev/src/
chmod 2750 /srv/techsoft/dev/database/
chmod 2770 /srv/techsoft/design/
chmod 2750 /srv/techsoft/management/
chmod 2754 /srv/techsoft/management/reports/
chmod 2700 /srv/techsoft/management/confidential/
chmod 2750 /srv/techsoft/devops/
chmod 2750 /srv/techsoft/devops/scripts/
chmod 2640 /srv/techsoft/devops/configs/
chmod 3775 /srv/techsoft/shared/
chmod 755 /srv/techsoft/logs/
