
# Notice GitHub Events


## Install

#### vi config.rb

```ruby
# config
$SAVING_ID_FILE = './cache/issues.id'
$USERNAME       = ''
$PASSWORD       = ''
$IRC_CHANNEL    = ''
$IRC_URL        = ''

$USER_TOKEN    = ''
```

#### setting clon

```bash
export PATH="$HOME/.rbenv/bin:$PATH"

*/5 * * * * /bin/bash -c 'eval "$(rbenv init -)"; cd /path/to/; ruby feeds.rb repo;'
```




