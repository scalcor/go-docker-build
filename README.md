# gox-docker-build

Dockerfile which accesses a Go project in the private repository and builds the docker image.
To access the private repository, ssh key file and the passphrase is required.
The final image - built with this Dockerfile - does not have any security-sensitive data, like key file nor passphrase.
