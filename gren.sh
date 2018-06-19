# Create release notes based on issues and update changelog

tagName=$(curl --silent "https://api.github.com/repos/jobinlawrance/gradle-styfi/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

gren release --tags=$tagName --override --token=$GREN_TOKEN

gren changelog --generate --override --token=$GREN_TOKEN
