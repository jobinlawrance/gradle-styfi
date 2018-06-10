# Get latest tag name and tarball url from github api
version=$(echo $tagName | cut -c 2-6)
artifactUrl=$(curl --silent "https://api.github.com/repos/jobinlawrance/gradle-styfi/releases/latest" | grep '"tarball_url":' | sed -E 's/.*"([^"]+)".*/\1/')

#download the tarball artifact and get SHA
wget -O artifact.tar.gz $artifactUrl
sha=$(sha256sum artifact.tar.gz | cut -d " " -f 1 )

message="Travis build: $TRAVIS_BUILD_NUMBER"

git clone git://${GH_REPO}

cd homebrew-hb-osx

constantsFileName="constants.rb"

# Creating a Ruby module class to store the constants
echo "module Constants"$'\r' > $constantsFileName
echo "  URL = \"$artifactUrl\""$'\r' >> $constantsFileName
echo "  SHA = \"$sha\""$'\r' >> $constantsFileName
echo "  VERSION = \"$version\""$'\r' >> $constantsFileName
echo "end" >> constants.rb

cat $constantsFileName

git remote
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

git add .
git commit -m "$message"
git push "https://${GH_TOKEN}@${GH_REPO}" master > /dev/null 2>&1