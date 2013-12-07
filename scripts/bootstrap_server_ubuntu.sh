#!/bin/bash

TOPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

HOSTNAME=${1:-open4us.org}
DBNAME=${2:-wordpress}
DBUSER=${3:-dbuser}
DBPASS=${4:-}

#
# Install base system dependencies
#

apt-get update
if apt-get -y install `cat ${TOPDIR}/config/required_packages.txt`
then
    echo "Required packages installed, proceeding with setup."
else
    echo "Could not install required packages, aborting setup."
    exit 1
fi

#
# Configure Apache:
#

# 1. Copy config files into place

cat <<EOF > /etc/apache2/sites-available/${HOSTNAME}
<VirtualHost *:80>
    ServerName ${HOSTNAME}
    DocumentRoot ${TOPDIR}/docroot

    ErrorLog /var/log/apache2/${HOSTNAME}/error.log
    CustomLog /var/log/apache2/${HOSTNAME}/access.log combined

    RewriteEngine On

    # WordPress rules
    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_FILENAME} !-f
    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]

    php_value upload_max_filesize 6M
</VirtualHost>
EOF

if [ -f /etc/ssl/private/${HOSTNAME}.key ]
then
    cat <<EOF >> /etc/apache2/sites-available/${HOSTNAME}
<VirtualHost *:443>
    ServerName ${HOSTNAME}
    DocumentRoot ${TOPDIR}/docroot

    ErrorLog /var/log/apache2/${HOSTNAME}/error.log
    CustomLog /var/log/apache2/${HOSTNAME}/access.log combined

    SSLEngine on
    SSLCertificateFile /etc/ssl/private/${HOSTNAME}.crt
    SSLCertificateKeyFile /etc/ssl/private/${HOSTNAME}.key
    SSLCACertificateFile /etc/ssl/certs/RapidSSL_CA_bundle.pem

    # WordPress rules
    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_FILENAME} !-f
    RewriteCond %{DOCUMENT_ROOT}%{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]

    php_value upload_max_filesize 6M
</VirtualHost>
EOF
fi

# 2. Create logging directory

mkdir -p /var/log/apache2/${HOSTNAME}
chown root.adm /var/log/apache2/${HOSTNAME}
chmod 750 /var/log/apache2/${HOSTNAME}

# 3. Enable mods and site

for i in php5 rewrite ssl
do
    a2enmod $i
done

a2ensite ${HOSTNAME}

# 4. Restart Apache

service apache2 restart

#
# Create a MySQL DB for WordPress
#

# run mysql to see if the root user has a password set
if mysql -u root -e ""
then
    mysql -u root mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${DBNAME};
GRANT ALL ON ${DBNAME}.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';
EOF
else
    echo "Enter the MySQL root password:"
    mysql -u root -p mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${DBNAME};
GRANT ALL ON ${DBNAME}.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';
EOF
fi
