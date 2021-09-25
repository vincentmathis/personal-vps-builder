# personal-vps-builder

Sets up nextcloud and bitwarden as docker containers with traefik as reverse proxy and mariadb as database.
(Modified from https://github.com/JoshBlades/ncbuilder)

## Install 

Start with conecting to your server, with ssh. 
The commands will be for bash (Linux). 

clone the repo to the server

```
https://github.com/vincentmathis/personal-vps-builder.git
```
Then go in to the folder and make the script executable. 
```
cd personal-vps-builder
chmod +x generate-password.sh setup.sh
```

You will need to configure the .env file (this is a hidden file).
The main thing to set is the email and the url 
```
TRAEFIK_LETSENCRYPT_EMAIL=
NEXTCLOUD_URL=
BITWARDEN_URL=
BASE_DATA_LOCATION=
```

the mariadb password will be set by the generate passwords script that will gerate random hex values as passwords. 
so run
```
./generate-password.sh 
```

And now all you need to do is run 

```
./setup.sh 
```
when this command has finished you can now go to your _website nextcloud.myurl.com or bitwarden.myurl.com_

## start and stop

If it all works you can start the server by docker compose with this command.  
```
sudo docker-compose up -d
```

to stop all the containers with 
```
sudo docker-compose down
```
