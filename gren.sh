# Create release notes based on issues and update changelog

gren release --tags=$tagName --override --token=${GREN_TOKEN}

gren changelog --token=${GREN_TOKEN}
