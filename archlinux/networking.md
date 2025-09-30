# nmcli

connecting to wifi network after rebooting

Get the list of SSID

nmcli device wifi list

nmcli device wifi connect <YourSSID> --ask

enter paraphrase

check the details using

nmcli --pretty show device <nameOfTheDevice>

In case you wish to disconnect

nmcli connection delete id <YourSSID>