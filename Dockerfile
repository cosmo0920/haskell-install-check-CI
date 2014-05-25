# use the ubuntu base image provided by dotCloud
FROM ubuntu:14.04

MAINTAINER cosmo0920 <cosmo0920.wp@gmail.com>

# setting apt
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y build-essential git libpq-dev libsqlite3-dev haskell-platform

# update and install cabal-install
RUN cabal update
RUN cabal install cabal-install --global --prefix=/usr/local

# Install yesod
RUN cabal install yesod yesod-bin persistent-postgresql persistent-sqlite \
    -fllvm --global --prefix=/usr/local

# RUN SSHD AS THIS CONTAINER'S DEFAULT PROCESS
CMD [ "/usr/sbin/sshd", "-D", "-o", "UseDNS=no", "-o", "UsePAM=no" ]
EXPOSE 22
