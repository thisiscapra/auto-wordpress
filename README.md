Created with help from:

* [https://github.com/simonpioli/auto-wordpress]
* [https://webdesigner-webdeveloper.com/weblog/automate-the-wordpress-install/]

### Setup for a Wordpress Theme based on Underscores

First You will need to install the following dependencies...

## Wordpress CLI

* `curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar`
* `chmod +x wp-cli.phar`
* `sudo mv wp-cli.phar /usr/local/bin/wp`

## Underscores

* `npm install -g underscores`

## Node/NPM (If not installed)

* `npm install npm@latest -g`
* `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash`

## Run the install script

This will setup Wordpress, with a DB, Grunt, and a selection of plugins

* `curl https://raw.githubusercontent.com/thisiscapra/auto-wordpress/master/auto-wordpress.sh | bash`