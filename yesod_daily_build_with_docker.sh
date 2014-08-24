export TWITTER_USER=kosmo__
export DATE="`date +\"%Y/%m/%d %H:%M:%S\"`"
export CABAL_COMMAND="cabal install yesod yesod-bin"
export BUILD_ENV="docker: 1.2.0 Ubuntu: 14.04 and HP: 2013.2.0.0"
export DOCKER_DATE="`date +\"%Y%m%d%H%M%S\"`"
echo "=== \"${CABAL_COMMAND}\" with ${BUILD_ENV} scheduled. at ${DATE} ===" | tw --user=${TWITTER_USER} --pipe
# prepare docker
boot2docker up
docker ps -a -q | xargs docker rm

# build phase
docker build -t yesodbox_"${DOCKER_DATE}" - < Dockerfile

# tweet phase
if [ $? == 0 ]; then
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" with ${BUILD_ENV} success! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
else
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" with ${BUILD_ENV} failure! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
fi

# clean phase
docker images | grep "^yesod" | awk '{print $3}' | xargs docker rmi
boot2docker stop
