export TWITTER_USER=kosmo__
export CABAL_COMMAND="cabal install yesod yesod-bin"
export DATE="`date +\"%Y/%m/%d %H:%M:%S\"`"
export BUILD_ENV="OSX: 10.8 ghc: 7.6.3 cabal: 1.20 and HP: 2013.2.0.0"
echo "=== \"${CABAL_COMMAND}\" with ${BUILD_ENV} scheduled. at ${DATE} ===" | tw --user=${TWITTER_USER} --pipe
# check versions
uname -mprsv
ghc --version
cabal --version

# clean work dir cabal environment
if [ -d .cabal-sandbox ]; then
  rm -rf ./.cabal-sandbox
fi
if [ -f cabal.sandbox.config ]; then
  rm cabal.sandbox.config
fi

# install vanilla yesod
cabal update
cabal sandbox init
cabal install alex happy
cabal install yesod yesod-bin

if [ $? == 0 ]; then
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" with ${BUILD_ENV} success! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
else
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" with ${BUILD_ENV} failure! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
fi
