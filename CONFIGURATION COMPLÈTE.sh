
# FACTURATION PAR DÉPARTEMENT – CUPS + PYKOTA
# Ubuntu Server / Debian
############################################################


# 1 INSTALLATION
############################

sudo apt update -y
sudo apt install -y cups python3-pykota pykota


# 2 ACTIVER CUPS
############################

sudo systemctl enable cups
sudo systemctl start cups


# 3 CRÉATION GROUPES DÉPARTEMENT
############################

sudo groupadd finance
sudo groupadd rh
sudo groupadd it
sudo groupadd administration


# 4 CRÉATION UTILISATEURS
############################

sudo useradd -m -G finance user_fin1
sudo useradd -m -G rh user_rh1
sudo useradd -m -G it user_it1
sudo useradd -m -G administration user_admin1


# 5 AJOUT IMPRIMANTE
############################
# Exemple IP imprimante

sudo lpadmin -p IMPRIMANTE_ENT \
-E \
-v socket://192.168.40.10:9100 \
-m everywhere

sudo cupsenable IMPRIMANTE_ENT
sudo cupsaccept IMPRIMANTE_ENT


# 6 CONFIGURATION PYKOTA
############################

sudo pkprinters --add IMPRIMANTE_ENT
sudo pkturnkey


# 7 DÉFINIR COÛT PAR PAGE
############################
# Exemple : 0.05$ par page noir & blanc

sudo pkusers --charge 0.05 finance
sudo pkusers --charge 0.05 rh
sudo pkusers --charge 0.05 it
sudo pkusers --charge 0.05 administration


# 8 DÉFINIR QUOTA GLOBAL (EX: 500 pages/mois)
############################

sudo pkusers --limitbygroup 500 finance
sudo pkusers --limitbygroup 500 rh
sudo pkusers --limitbygroup 500 it
sudo pkusers --limitbygroup 500 administration


# 9 ACTIVER LOGS
############################

sudo systemctl restart cups

############################
# FIN CONFIGURATION
############################
