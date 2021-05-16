## How to release a new tool version

### Checklist
* Ensure working dir is clean
* Update version in `mix.exs`
* Create a commit:
```sh
 git commit -a -m "Bump version to 0.X.Y"
  git tag v0.X.Y
  mix test && mix hex.publish
  git push --tags
```
