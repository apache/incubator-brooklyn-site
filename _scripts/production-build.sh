#!/bin/bash -e

set -x

rm -rf _site
( jekyll build --config _config.yml,_scripts/production-config.yml && 
    echo site docs are in `pwd`/_site ) ||
  echo ERROR - could not build docs in `pwd`

