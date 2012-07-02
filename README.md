
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
*/5 * * * * /bin/bash -c 'export PATH="$HOME/.rbenv/bin:$PATH" ; eval "$(rbenv init -)"; ruby /path/to/issues.rb repo;'
*/5 * * * * /bin/bash -c 'export PATH="$HOME/.rbenv/bin:$PATH" ; eval "$(rbenv init -)"; ruby /path/to/feeds.rb repo;'
```




