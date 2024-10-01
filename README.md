# go-docker-build

Dockerfile which accesses a Go project in the private repository and builds the docker image.
To access the private repository, ssh key file and the passphrase is required.
The final image - built with this Dockerfile - does not have any security-sensitive data, like key file nor passphrase.

## build
```sh
# to access https://github.com/user/app.git
APP=app GIT_USER=user ./build.sh
```

## environment variables

`APP`: repository name.

`GIT_SERVER`: server URL. (default: github.com)

`GIT_USER`: user name.

`KEY_FILE`: path of the key file. (default: ./id_github)

`KEY_PASSPHRASE`: passphrase of the key file.
