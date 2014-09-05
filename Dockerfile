# use the ubuntu base image provided by dotCloud
FROM ubuntu:14.04

MAINTAINER cosmo0920 <cosmo0920.wp@gmail.com>

# setting apt
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN add-apt-repository -y ppa:hvr/ghc
RUN apt-get update
RUN apt-get install -y build-essential git libpq-dev libsqlite3-dev ghc-7.8.3 cabal-install-1.20 # avoid using `haskell-platform`

# locale setting
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LC_ALL C
ENV LC_ALL en_US.UTF-8

# update and install cabal-install
RUN cabal update
RUN cabal install cabal-install --global --prefix=/usr/local

# Install yesod
RUN cabal install yesod yesod-bin \
    -fllvm --global --prefix=/usr/local

# RUN SSHD AS THIS CONTAINER'S DEFAULT PROCESS
CMD [ "/usr/sbin/sshd", "-D", "-o", "UseDNS=no", "-o", "UsePAM=no" ]
EXPOSE 22
