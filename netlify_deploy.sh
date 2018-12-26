#!/bin/bash

# halt script on error
set -ev

zip -r website.zip dist

if [ "$TRAVIS_BRANCH" = "master" ] ; then
    curl -H "Content-Type: application/zip" \
        -H "Authorization: Bearer $token" \
        --data-binary "@website.zip" \
        https://api.netlify.com/api/v1/sites/44259856-784c-4e35-a14c-6dd6174be654/deploys
    echo "Build successful, publishing in production environment!"

elif [ "$TRAVIS_BRANCH" = "develop" ] ; then
    curl -H "Content-Type: application/zip" \
            -H "Authorization: Bearer $token" \
            --data-binary "@website.zip" \
            https://api.netlify.com/api/v1/sites/44259856-784c-4e35-a14c-6dd6174be654/deploys
    echo "Build successful, publishing in develop environment!"

else
  echo "Build successful, but not publishing!"
fi