sudo service docker status
sudo dervice docker stop
sudo service docker start

sudo pkill dockerd
sudo dockerd &

ss -lntp | grep 2375

curl http://localhost:2375/containers/json