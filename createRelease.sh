#!/bin/bash

RELEASE_VERSION=$1 # e.g. 2.16.0

if [ -z "$RELEASE_VERSION" ]
then
      echo "No RELEASE_VERSION passed as parameter. Usage ./createRelease.sh 0.0.0"
else
      RELEASE_NAME="release-$RELEASE_VERSION"
      echo "Creating $RELEASE_NAME branch from latest state of develop branch"
#      git checkout develop && git pull && git checkout -b "$RELEASE_NAME"

      ### Update version code by adding 1 ###
      VERSION_CODE_LINE=$(sed -n '/versionCode/ s/^.*versionCode/versionCode/p' app/build.gradle) # VERSION_CODE_LINE is versionCode 123
      VERSION_CODE=${VERSION_CODE_LINE#*versionCode } # VERSION_CODE is 123
      NEW_VERSION_CODE=$((VERSION_CODE + 1)) # NEW_VERSION_CODE is 124
      echo "Updating versionCode from $VERSION_CODE to: $NEW_VERSION_CODE"
      sed "s/$VERSION_CODE_LINE/versionCode $NEW_VERSION_CODE/" app/build.gradle > app/build.gradle.temp && mv app/build.gradle.temp app/build.gradle

      TAG_NAME="$RELEASE_VERSION-alpha.1"
      echo "Creating tag: $TAG_NAME"
#      git tag -a "$TAG_NAME" -m "Create tag $TAG_NAME"

      echo "Now you can look at the changes and push them :)"
#      git diff
fi
