#!/bin/bash
#
# Author: Ivan Tomica <ivan@tomica.net>
#
# Script reads login credentials from configured backend
# Script tries to wrap Hashicorp's Vault and provide profile switcher
# - it reads VAULT_ADDR environment variable and tries to log in there
# - in order to perform the login, it requires token to be saved in the file
# - later we might add other backends, such as gnome keyring

VLTS_HOME=~/.vlts.d/
VLTS_LOGIN_METHOD="github"

# Load configuration file if it exists
if [ -e ~/.vltsrc ]; then
    . ~/.vltsrc
fi

if [ ! -d "$VLTS_HOME" ]; then
    umask 0077
    mkdir -p $VLTS_HOME
fi

function vlts_url_cleanup(){
    VAULT_ADDRESS="$(echo $VAULT_ADDR | sed 's/^https\:\/\///g' | sed 's/^http\:\/\///g' | sed 's/\:/_/g')"
}

function vlts_login(){
    vlts_url_cleanup
    VLTS_SOURCE_CONFIG="$VLTS_HOME$VAULT_ADDRESS.conf"
    if [ -e "$VLTS_SOURCE_CONFIG" ]; then
	. $VLTS_SOURCE_CONFIG
	if [ ! -z $VLTS_GITHUB_TOKEN ]; then
	    # If not provided, will it prompt for the token? What about method?
	    # Flag provided but not defined - token
	    vault login -method=$VLTS_LOGIN_METHOD token=$GITHUB_TOKEN
	# We could support multiple auth menthods here (app_id/app_role/azure/whatever)
	else
	    echo "VLTS_GITHUB_TOKEN not defined in $VLTS_SOURCE_CONFIG."
	fi
    else
	echo "Configuration file $VLTS_SOURCE_CONFIG for the $VAULT_ADDR does not exist."
    fi
}

vlts_login
# function vlts_switch(){
#     # We could move ~/.vault_token around, but need to check its timestamp
#     # due to the token expiration which is by default
# }
