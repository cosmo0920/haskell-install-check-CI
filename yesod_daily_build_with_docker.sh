export DATE="`date +\"%Y%m%d%H%M%S\"`"
export CABAL_COMMAND="cabal install yesod yesod-bin"
export BUILD_ENV="docker: 0.11.1 Ubuntu: 14.04 ghc: 7.6.3 cabal: 1.20"
echo "=== \"${CABAL_COMMAND}\" with ${BUILD_ENV} scheduled. at ${DATE} ===" | tw --user=${TWITTER_USER} --pipe
# prepare docker
boot2docker up
docker ps -a -q | xargs docker rm

# build phase
docker build -t yesodbox_"${DATE}" - < Dockerfile

# clean phase
docker rmi $(docker images | grep "^yesod" | awk "{print $3}")
boot2docker stop
if [ $? == 0 ]; then
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" with ${BUILD_ENV} success! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
else
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" with ${BUILD_ENV} failure! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
fi
