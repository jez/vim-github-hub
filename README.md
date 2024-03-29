# vim-github-hub

> A Vim filetype plugin for [github/hub][hub] :zap:

![A screenshot of this plugin in action](vim-github-hub.png)

This plugin does filetype detection and syntax highlighting for buffers/files
created by [github/hub][hub], a utility for working with Git + GitHub
from the command line. In particular, this plugin does fancy things when you're
using hub to create new issues and pull requests.


## Features

- Detect `ISSUE_EDITMSG` and `PULLREQ_EDITMSG` as a custom filetype.
- Use this custom filetype to highlight as markdown
  - Support vim-pandoc syntax highlighting if we see it installed
- Detect comment character to highlight comments appropriately
  - Thus, if you use an alternate comment character with hub, ATX-style headings
    are highlighted correctly.


## Install

Install using your favorite plugin manager. For example, to install using
Vundle, add this line to your ~/.vimrc:

```
Plugin 'jez/vim-github-hub'
```

If you're unfamiliar with using Vim plugins, check out [Vim as an IDE][vim-ide] which
will get you up to speed.

Independently of installing the plugin, if you'd like to use `%` as the comment
character with hub, I recommend these aliases:

```shell
# Markdown pull request with hub
alias hubmdpr="hub -c core.commentChar='%' pull-request"

# Markdown issue with hub
alias hubmdis="hub -c core.commentChar='%' issue create"
```

## Contributing

I actively welcome pull requests and issues. Feel free open them at your
leisure.


## License

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://jez.io/MIT-LICENSE.txt)

Copyright Jake Zimmerman. <jake@zimmerman.io>

[hub]: https://github.com/github/hub
[vim-ide]: https://github.com/jez/vim-as-an-ide
