# Purpose 
Request SSL cert from letsencrypt and store it for use in Parameter Store

# Benefits
1. An automated process for certificate request and renewal.
2. Free letsencrypt CA (consider contributing )

# Drawback

Site is down during renewal - a few seconds

# Key Implementation Details

1. CA needs to know that the domain belongs to you, it does this by connecting to `<your domain>:80` ( your domain - is the domain the certificate is for ). 

2. `certbot-auto` starts up a http server at port 80(ensure that port 80 can be reached via `<your domain>:80`) this is achived partly through container port mapping in the ContainerDefinitions section
```
          PortMappings:
            - ContainerPort: 80
              HostPort: 80
```
3. `certbot-auto` then begins the handshake with the letsencrypt CA service. letsencryt CA will first verify that it can connect to `<your domain>:80`  ( which should be available given #2 ) 

# Usage

1. Stop your web front by setting the related task desired count to 0

2. Start the certrenewal task desired count to 1, once the SSL certs are available in parameter store shut it down by setting the task desired count to 0 and replace it with your web front.

Renewal follows the same process.

# Dependencies
1. A domain name
2. A cluster(EcsClusterExportName) to place the container
2. Reachable ecs service to container

