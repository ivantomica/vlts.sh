# vlts.sh

vlts.sh is a small, shell-based (bash) utility which reads login credentials from configured backend and performs login with those credentials against Vault instance specified in VAULT_ADDR environment variable

## Requirements

- Script requires that vault binary is available within $PATH.
- Address of the Vault instance already configured via VAULT_ADDR environment variable
- Login credentials saved in used storage backend according to the selected auth method

## Misc

Login credentials are sourced by default from ~/.vlts.d/ directory, unless specified differently by VLTS_HOME in ~/.vltsrc

Login process reads VAULT_ADDR environment variable and removes URL prefix (http:// or https://) and replaces port separator (:) with underscore (:). That string is used to lookup login credentials. Based on the storage backend used, lookup key might have prefix or suffix added (.conf for file storage backend)


## To-Do

- Implement backends other than file-based secrets storage (gnome-keyring/libsecret/1password etc.)
- Helper function - or re-think usage in order to allow for single-step vault instance switch
