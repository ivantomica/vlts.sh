# vlts.sh

vlts.sh is small, shell-based (bash) utility which reads login credentials from configured backend and performs login with those credentials against vault specified in VAULT_ADDR environment variable

## Requirements

Script requires that vault binary is available within $PATH.

Login credentials

## Misc

Login credentials are sourced by default from ~/.vlts.d/ directory, unless specified differently by VLTS_HOME in ~/.vltsrc

Login process reads VAULT_ADDR environment variable and removes URL prefix (http:// or https://) and replaces port separator (:) with underscore (:). That string is used to lookup login credentials. Based on the storage backend used, lookup key might have prefix or suffix added (.conf for file storage backend)

## To-Do

- Why? -> Autocomplete based on available login credentials (file listing in VLTS_HOME, list of keys in gnome-keyring, etc.)
-
