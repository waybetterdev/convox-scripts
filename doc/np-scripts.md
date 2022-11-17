
# NP Scripts and their usage

## NPS Config

Script that links services in between them. Run this when you switch location for services. e.g. switch from using an external user service to running a local user service.

### TODO: Add documentation



## NPS Env

Ruby script that builds environment variables for each service. It reads the config file from `./local-settings/np-services-config.rb` and automatically generates domain names for each service so that the services can talk to each other. 

For example, if you mark `user-service` as running locally inside a convox container with 
```
LOCAL_CONVOX_SERVICES = %i[graphql]
```
then all services that talk to `user-service` will access it as `wb-user-service.convox.local`. This route will pass through our apache proxy, which will provide the self-signed certificates needed for SSL.

### Usage:

You can use `npenv` for editing or writing config files:
`npenv -w -a user` will generate the ENV variables for user service
`npenv -e -a user` will open a text editor and you will be able to change ENV variables for user srevice.


Full option list printed by `npsenv --help`
```
  Env builder script for local NP services
  Ex:
    npsenv -w -a user

Specific options:
    -z, --debug                      Optional: load pry
    -w, --write                      Write the env to kraken or convox
    -p, --print                      Print the env to kraken or convox
    -e, --edit                       Edit the env on kraken or convox
    -a, --app=A                      Required, NP application name
    -h, --help                       Prints this help
```

**Service locations:**
1. local kraken - services that run directly in rails or npm with `npsrun` without any docker or convox containers.
2. local convox - services that run inside a convox container on local development rack.
3. convox office - services that run inside a convox container on a standalone server that we keep in our office are able to access from anywhere.



 
## NPS Install

### TODO: Add documentation




## NPS Run

### TODO: Add documentation