# Shutdown command

It is been almost 2 years I have been using Linux.<br>
Today I realized (after reading man pages), that<br>
shutdown command is used not only for shutdown but also for reboot.

`shutdown -r now` is equivalent to `shutdown -r +0`
Initally I used to do is 

```shell
# previously
shutdown -r $(date --date +5min +%H:%M)

# now, reboot in 5 minutes
shutdown -r +5

# little advance
shutdown -r +5 'Rebooting after applying patches Security Only'
