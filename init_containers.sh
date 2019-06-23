set -x
# Todo set logging retention.
docker network create gaussmeter
docker container run --detach --restart always --volume /home/pi/badger_data:/tmp/badger --network gaussmeter --name config gaussmeter/config:latest
docker container run --detach --restart always --privileged                              --network gaussmeter --name lumen  gaussmeter/lumen:latest
docker container run --detach --restart always --publish 9001:9001                       --network gaussmeter --name front  gaussmeter/front:latest 
docker container run --detach --restart always                                           --network gaussmeter --name query  gaussmeter/query:latest
