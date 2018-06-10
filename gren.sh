# Create release notes based on issues and update changelog

gren --override --tags=$tagName

gren --action=changelog
