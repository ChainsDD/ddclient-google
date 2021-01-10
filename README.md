# ddclient-google

A small Docker image for updating Google DDNS using ddclient.

It uses environment variables for setting the username, password, and domains to update.

## Usage
```
docker run -d \
    --env DDNS_USERNAME=[generated username] \
    --env DDNS_PASSWORD=[generated password] \
    --env DDNS_DOMAIN=[domain to be updated] \
    --restart=unless-stopped \
    --name ddclient \
    chainsdd/ddclient
```

## Building
```
docker build \
    --build-arg DDCLIENT_VER=3.9.1 \
    --tag ddclient-google .
```