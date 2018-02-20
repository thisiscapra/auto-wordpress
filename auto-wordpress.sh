#!/bin/bash

# ========================================
# CHECK FOR DEPENDENCIES
# ========================================

# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
command -v wp cli version >/dev/null 2>&1 || { echo >&2 "WP-CLI is required for this script. Aborting."; exit 1; }
command -v underscores >/dev/null 2>&1 || { echo >&2 "Underscores is required for this script - https://www.npmjs.com/package/underscores. Aborting."; exit 1; }
command -v node --version >/dev/null 2>&1 || { echo >&2 "Node is required for this script. Aborting."; exit 1; }


# ========================================
# PATHS
# ========================================

echo "==================================================================="
echo "In what directory do your install Wordpress?"
echo "e.g. Sites / Development"
echo "========================================================================="

read -e project_path

target_dir=~/$project_path/

# ========================================
# USER INPUT
# ========================================

echo "(1/5) ==================================================================="
echo "Please enter a projectname:"
echo "This name will be used for a new folder that contains the WP installation"
echo "========================================================================="
read -e project_name

echo "(2/5) ==================================================================="
echo "Please enter a name for the database:"
echo "========================================================================="
read -e db_name

echo "(3/5) ==================================================================="
echo "Please enter a database prefix :"
echo "========================================================================="
read -e db_prefix
     db_prefix=${db_prefix:-wp_}

echo "(4/5) ==================================================================="
echo "Please enter a name for the database user:"
echo "========================================================================="
read -e db_user

echo "(5/5) ==================================================================="
echo "Please enter a password for the database:"
echo "========================================================================="
read -s db_password

# ========================================
# CREATE DATABASE AND DATABASE-USER
# ========================================

echo "Creating the database..."
mysql -u root -p "" -e "CREATE DATABASE $db_name; \
GRANT ALL PRIVILEGES ON $db_name.* TO $db_user@localhost IDENTIFIED BY '$db_password'; \
FLUSH PRIVILEGES;"

# ========================================
# DOWNLOAD - CONFIGURE AND INSTALL WP
# ========================================

cd $target_dir && \
mkdir $project_name && \
cd $project_name && \
wp core download && \
wp core config --dbname=$db_name --dbuser=$db_user --dbpass=$db_password --dbprefix=$db_prefix && \
wp core install --prompt && \

# ========================================
# DOWNLOAD THE UNDERSCORES STARTER THEME
# ========================================

cd wp-content/themes && underscores -n $project_name --author "Capra Design" --url "https://thisiscapra.com" --sass && \
cd $project_name && \

# ========================================
# CREATE PACKAGE FILE AND INSTALL PACKAGES
# ========================================

npm init && \
npm install --save-dev grunt && \
npm install --save-dev grunt-contrib-sass && \
npm install --save-dev grunt-contrib-watch && \
npm install --save-dev grunt-contrib-uglify && \

# ========================================
# DOWNLOAD GRUNTFILE
# ========================================

curl -LO https://raw.githubusercontent.com/thisiscapra/auto-wordpress/master/Gruntfile.js

# ========================================
# INSTALL SOME PLUGINS
# ========================================

# All-in-One-SEO-Pack
echo "Fetching All-in-One-SEO-Pack plugin...";
curl -O http://downloads.wordpress.org/plugin/all-in-one-seo-pack.zip;
unzip -q all-in-one-seo-pack.zip;
mv all-in-one-seo-pack wordpress/wp-content/plugins/

# Sitemap Generator
echo "Fetching Google Sitemap Generator plugin...";
curl -O http://downloads.wordpress.org/plugin/google-sitemap-generator.zip; 
unzip -q  google-sitemap-generator.zip; 
mv google-sitemap-generator wordpress/wp-content/plugins/

# Secure WordPress
echo "Fetching Secure WordPress plugin...";
curl -O http://downloads.wordpress.org/plugin/secure-wordpress.zip;
unzip -q  secure-wordpress.zip;
mv secure-wordpress wordpress/wp-content/plugins/

# Super-cache
echo "Fetching Super Cache plugin...";
curl -O http://downloads.wordpress.org/plugin/wp-super-cache.zip;
unzip -q  wp-super-cache.zip;
mv wp-super-cache wordpress/wp-content/plugins/

# Regenerate Thumbnails (good for when you need to make custom sizes)
echo "Fetching Regenerate Thumbnails...";
curl -O http://downloads.wordpress.org/plugin/regenerate-thumbnails.zip
unzip -q regenerate-thumbnails.zip
mv regenerate-thumbnails wordpress/wp-content/plugins/

# Advanced Custom Fields
echo "Fetching Advanced Custom Fields...";
curl -O http://downloads.wordpress.org/plugin/advanced-custom-fields.zip
unzip -q advanced-custom-fields.zip
mv advanced-custom-fields wordpress/wp-content/plugins/

# WordPress Importer
echo "Fetching WordPress Importer...";
curl -O http://downloads.wordpress.org/plugin/wordpress-importer.zip
unzip -q wordpress-importer.zip
mv wordpress-importer wordpress/wp-content/plugins/

# Cleanup
echo "Cleaning up temporary files and directories...";
rm *.zip
rm *.tar.gz