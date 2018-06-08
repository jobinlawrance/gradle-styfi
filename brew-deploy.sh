
tagName=$(curl --silent "https://api.github.com/repos/jobinlawrance/gradle-styfi/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
artifactUrl=$(curl --silent "https://api.github.com/repos/jobinlawrance/gradle-styfi/releases/latest" | grep '"tarball_url":' | sed -E 's/.*"([^"]+)".*/\1/')

wget -O artifact.tar.gz $artifactUrl
sha=$(sha256sum artifact.tar.gz | cut -d " " -f 1 )

message="Travis build: $TRAVIS_BUILD_NUMBER"

git clone $GH_REPO

cd homebrew-hb-osx
echo "module Constants \n  URL = \"$artifactUrl\" \n  SHA = \"$sha\" \n  VERSION = \"$tag\" \nend" > constants.rb
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

git add .
git commit -m $message
git push "https://${GH_TOKEN}@${GH_REPO}" master 