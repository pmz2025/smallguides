# Installing linkding

Here I'm installing linkding for Fedora42. Took quite a while to understand why it was failing.
Because SE Linux were not set.

```shell
export LINKDING=$HOME/Documents/favdatabase
mkdir -pv $LINKDING

# add user to the docker group
sudo usermod -aG docker

docker run --name linkding -p 9090:9090 -v $LINKDING:/etc/linkding/data:Z -d ghcr.io/sissbruecker/linkding:latest

docker exec -it linkding python manage.py createsuperuser --username=repolevedp --email=repolevedp@gmail.com
```
