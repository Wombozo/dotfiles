Create a file ext.fish in the autoload's fish conf.d/ containing :

```
for conf in (readlink -f ~/dotfiles/fish/conf.d/*);
  source $conf
end
```
