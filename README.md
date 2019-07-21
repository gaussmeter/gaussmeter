
# Gaussmeter

#### gauss
One gauss equals 1×10<sup>−4</sup> tesla (100 μT)

#### meter
a device that measures and records the quantity, degree, or rate of something.

# Hardware

## raspbery Pi Zero W

## Neopixel (WS2812)


# Services
All services run in docker containers and communicate via RESTish HTTP interfaces using JSON messages

## front

Web interface for Gaussmeter. Serves static web pages and proxies calls to config and token services.

|path|methods|purpose|
|---|---|---|
|/| GET|serve web interface|
|/badger/[key]|GET,PUT,POST|store or retrieve key:value pair|
|/streamer/[key_prefix]|GET|return all of the keys:values in JSON format|
|/secret/[key]|PUT,POST|store key:value pair|
|/secret/[key]|GET|return 200 "hidden" if the secret exists -or- 404 (empty body) if the secret does not exist

https://github.com/gaussmeter/front

## config

Key:Value store with RESTish interface. Using [BadgerDB v1.6.0](https://github.com/dgraph-io/badger/tree/v1.6.0)

|path|methods|purpose|
|---|---|---|
|/badger/[key]|GET,PUT,POST|store or retrieve key:value pair|
|/streamer/[key_prefix]|GET|return all of the keys:values in JSON format|
|/secret/[key]|GET,PUT,POST|store or retrieve key:value pair|

##### secrets
- when stored/retrieved "secret:" is prepended to the key before the key:valued is stored in Badger 
- a request to /badger/secret:* or /streamer/secret:* will return 403 (forbidden)
- to protect secrets the`config` services should not exposed publicly, it should sit behind another service like `front`

https://github.com/gaussmeter/config

## token

Retrieves new auth token from Tesla, and renews existing token.

|path|methods|purpose|
|---|---|---|
|/tToken/|POST|retrieve a token from Tesla API/Auth|

Every 24 hours `http://config/secret/tToken` is retrieved, if the token is set to expire in the next 7 days the token is renewed, and stored back to `http://config/secret/tToken`. 

https://github.com/gaussmeter/token

## lumen

Drives Neopixels (WS2812)

https://github.com/gaussmeter/lumen

## query

 - Queries Tesla API for vehicle status 
 - Retrieves the vehicle status and stores it in the config service.  
 - Sends commands to lumen based on the status of the vehicle.

https://github.com/gaussmeter/query

## ouroboros (optional)
Ouroboros monitors all running docker containers and updates them to the latest available image in the remote registry. 
https://github.com/pyouroboros/ouroboros/issues

#### Todo
- examples (curl)
- details
  - lumen: json message format
  - query: use of config values
  - front: web interface
  - config: `default:*` key behaviour
- split documentation out to individual projects 
- installation
- licenses... 


