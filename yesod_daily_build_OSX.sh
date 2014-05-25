export TWITTER_USER=kosmo__
export CABAL_COMMAND="cabal install yesod yesod-bin"
export DATE="`date +\"%Y/%m/%d %H:%M:%S\"`"
echo "=== \"${CABAL_COMMAND}\" scheduled. at ${DATE} ===" | tw --user=${TWITTER_USER} --pipe
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
  echo "\"${CABAL_COMMAND}\"\nsuccess! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
else
  echo "\"${CABAL_COMMAND}\"\nfailure! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
fi
