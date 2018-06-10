# Create release notes based on issues and update changelog

gren release --tags=$tagName --override --token=[$GH_TOKEN] 

gren changelog --token=[$GH_TOKEN]
