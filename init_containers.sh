set -x
docker network create gaussmeter
docker container run --detach --restart always --network gaussmeter --name lumen --privileged  gaussmeter/lumen:latest
docker container run --detach --restart always --network gaussmeter --name teslamater -env LUMEN_HOST=http://lumen:9000/lumen -env MQTT_HOST=ws://192.168.1.51:9001 gaussmeter/teslamater:latest
