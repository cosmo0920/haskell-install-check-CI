Jenkins build scripts for daily job
===

__Currently, these scripts are alpha version.__

This script is used CI notify bot [@kosmo\_\_](https://twitter.com/kosmo__)

daily job executes following command:
```bash
cabal install yesod yesod-bin
```

## Job script description

* yesod\_daily\_build\_OSX
    + CI for OSX Environment
* yesod\_daily\_build\_with\_Docker
    + CI for Docker Envioronment
* yesod\_daily\_build\_linux
    + CI for Ubuntu Linux Environment(Currently not used. For reference only.)
