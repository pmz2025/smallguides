# Security Notes

check inside all users authorized keys

ls -la $HOME/*/.ssh/authorized_keys

key point here is `*` inside home directory.

Check which services are running

sudo systemctl list-units --type service --state running