#!/bin/bash

if ! grep -Fq SNAPSHOT gradle.properties && [ "$TRAVIS_REPO_SLUG" == "axe-felix/travis-publish-tags" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  gradle publish  
  cp -R build/repo $HOME/repo
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git clone --quiet https://${GH_TOKEN}@github.com/axe-felix/travis-test-mvn-repo > /dev/null
  cd travis-test-mvn-repo
  cp -R $HOME/repo .
  git add .
  git commit -m 'release'
  git push origin master > /dev/null  
fi