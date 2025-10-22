# Purpose: Declare the variable for restoring or taking backup.
# The variables are defined as per the help/man page
# Key or password is changed and stored in as encrypted file encrypted USB key.
# The encrypted file is encrypted using gnuPG and gnuPG is stored on yubikey (22462378)
# declare the important variables
# 

set RESTIC_PASSWORD_COMMAND "gpg --decrypt --quiet myTrueResticPasswd.gpg.asc"
set RESTIC_REPOSITORY $HOME/westerndigitial

# mount the directory

sudo mount -v /dev/disk/by-uuid/b3a9c52a-92a4-4e05-b533-026874f544b6 $RESTIC_REPOSITORY

# check the snapshots

restic -r $RESTIC_REPOSITORY --password-command $RESTIC_PASSWORD_COMMAND snapshots