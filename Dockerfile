# use the ubuntu base image provided by dotCloud
FROM ubuntu:14.04

MAINTAINER cosmo0920 <cosmo0920.wp@gmail.com>

# setting apt
RUN sed 's/main$/main restricted universe multiverse/' -i /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y build-essential git libpq-dev libsqlite3-dev ghc cabal-install # avoid using `haskell-platform`

# locale setting
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LC_ALL C
ENV LC_ALL en_US.UTF-8

# Install yesod
RUN cabal update
RUN cabal install alex happy \
    -fllvm --global --prefix=/usr/local
RUN cabal install yesod yesod-bin aeson-0.7.0.6 \
    -fllvm --global --prefix=/usr/local

# RUN SSHD AS THIS CONTAINER'S DEFAULT PROCESS
CMD [ "/usr/sbin/sshd", "-D", "-o", "UseDNS=no", "-o", "UsePAM=no" ]
EXPOSE 22
