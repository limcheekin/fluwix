git branch -r | grep -v '\\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
