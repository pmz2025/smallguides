# Installing linkding

Here I'm installing linkding for Fedora42. Took quite a while to understand why it was failing.
Because SE Linux were not set.

docker run --name linkding -p 9090:9090 -v /home/xpreetam/Documents/favdatabase:/etc/linkding/data:Z -d ghcr.io/sissbruecker/linkding:latest

docker exec -it linkding python manage.py createsuperuser --username=preetam --email=preetamzare@gmail.com