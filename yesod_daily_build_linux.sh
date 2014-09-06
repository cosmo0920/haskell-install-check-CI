export TWITTER_USER=kosmo__
export CABAL_COMMAND="cabal install yesod yesod-bin aeson-0.7.0.6"
export DATE="`date +\"%Y/%m/%d %H:%M:%S\"`"
export BUILD_ENV="Ubuntu: 14.04 ghc: 7.8.3 cabal: 1.20"
if [ ! -d vendor/bundle ]; then
    bundle install --path vendor/bundle
fi
echo "=\"${CABAL_COMMAND}\" with ${BUILD_ENV} sched. at ${DATE}=" | bundle exec tw --user=${TWITTER_USER} --pipe
# check versions
uname -mprsv
ghc --version
cabal --version

# add opt env setting
export PATH="/opt/ghc/7.8.3/bin:/opt/cabal/1.20/bin:$PATH"

# clean work dir cabal environment
if [ -d .cabal-sandbox ]; then
  rm -rf ./.cabal-sandbox
fi
if [ -f cabal.sandbox.config ]; then
  rm cabal.sandbox.config
fi

export NCPU=`cat /proc/cpuinfo | grep processor | wc -l`
# install vanilla yesod
cabal update
cabal sandbox init
cabal install alex happy
cabal install -j${NCPU} yesod yesod-bin aeson-0.7.0.6

if [ $? == 0 ]; then
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" success! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
else
  echo "${BUILD_ENV} \"${CABAL_COMMAND}\" failure! at ${DATE}" | tw --user=${TWITTER_USER} --pipe
fi
