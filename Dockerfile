# build stage
FROM golang:latest AS build

ARG GIT_SERVER=github.com
ARG GIT_USER
ARG APP
ARG SSH_KEY
ARG KEY_PASSPHRASE

RUN git config --global url."git@$GIT_SERVER:".insteadOf https://$GIT_SERVER/ \
 && go env -w GOPRIVATE=$GIT_SERVER/$GIT_USER

WORKDIR /go/src

RUN mkdir /root/.ssh \
 && ssh-keyscan $GIT_SERVER > /root/.ssh/known_hosts \
 && echo "$SSH_KEY" > /root/.ssh/id_rsa \
 && chmod 600 /root/.ssh/id_rsa \
 && printf "Host github.com\n\tAddKeysToAgent yes\n\tIdentityFile ~/.ssh/id_rsa\n" > /root/.ssh/config \
 && eval "$(ssh-agent -s)" && printf "$KEY_PASSPHRASE\n" | ssh-add $HOME/.ssh/id_rsa \
 && git clone https://$GIT_SERVER/$GIT_USER/$APP.git

WORKDIR $APP
RUN go get -d -v ./... \
 && go install -v ./... \
 && rm -rf /root/.ssh

# run stage
FROM golang:latest

ARG APP
WORKDIR /go/bin
COPY --from=build /go/bin/ .
CMD ["/go/bin/$APP"]
