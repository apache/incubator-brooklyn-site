#!/bin/bash -e

function build() {
  echo JEKYLL running with: jekyll build --config _config.yml,_build/production-config.yml
  jekyll build --config _config.yml,_build/production-config.yml || return 1
  echo JEKYLL completed, now promoting _site/website/ to _site/
  # the generated files are already in _site/ due to url rewrites along the way, but images etc are not
  cp -r _site/website/* _site/
  rm -rf _site/website 
  echo FINISHED: website pages are in `pwd`/_site 
}

rm -rf _site
build || echo ERROR: could not build docs in `pwd`

