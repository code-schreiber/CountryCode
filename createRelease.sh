#!/bin/bash

VERSION_NAME_LINE=$(sed -n '/versionName/ s/.*versionName/versionName/p' app/build.gradle) # VERSION_CODE_LINE is versionName "0.1.0"
VERSION_NAME=$(sed -e 's/^.* "//' -e 's/"$//' <<< "$VERSION_NAME_LINE") # VERSION_NAME is 0.1.0
VERSION_NAME_MAYOR=$(sed -e 's/\..*//' <<< "$VERSION_NAME")
VERSION_NAME_MINOR=$(sed -e 's/.\.//' -e 's/\..*//' <<< "$VERSION_NAME") # VERSION_NAME_MINOR is 1
NEW_VERSION_NAME="$VERSION_NAME_MAYOR.$((VERSION_NAME_MINOR + 1)).0" # NEW_VERSION_NAME is 0.2.0

if [ -z "$NEW_VERSION_NAME" ]
then
      echo "Error finding out NEW_VERSION_NAME"
else
      RELEASE_NAME="release-$NEW_VERSION_NAME"
      echo "Creating $RELEASE_NAME branch from latest state of develop branch"
#      git checkout develop && git pull && git checkout -b "$RELEASE_NAME"

      ### Update version code by adding 1 ###
      VERSION_CODE_LINE=$(sed -n '/versionCode/ s/.*versionCode/versionCode/p' app/build.gradle) # VERSION_CODE_LINE is versionCode 123
      VERSION_CODE=${VERSION_CODE_LINE#*versionCode } # VERSION_CODE is 123
      NEW_VERSION_CODE=$((VERSION_CODE + 1)) # NEW_VERSION_CODE is 124
      echo "Updating versionCode from $VERSION_CODE to $NEW_VERSION_CODE"
      sed "s/$VERSION_CODE_LINE/versionCode $NEW_VERSION_CODE/" app/build.gradle > app/build.gradle.temp && mv app/build.gradle.temp app/build.gradle

      ### Update version name by adding 1 to the minor version ###
      echo "Updating versionName from $VERSION_NAME to $NEW_VERSION_NAME"
      sed "s/$VERSION_NAME_LINE/versionName \"$NEW_VERSION_NAME\"/" app/build.gradle > app/build.gradle.temp && mv app/build.gradle.temp app/build.gradle

      TAG_NAME="$NEW_VERSION_NAME-alpha.1"
      echo "Creating tag: $TAG_NAME"
#      git tag -a "$TAG_NAME" -m "Create release tag $TAG_NAME"

      echo "Now you can look at the changes and push them :)"
#      git diff
fi
