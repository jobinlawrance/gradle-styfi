# Create release notes based on issues and update changelog

gren --override --tags=$tagName --token=[$GH_TOKEN]

gren --action=changelog --token=[$GH_TOKEN]
