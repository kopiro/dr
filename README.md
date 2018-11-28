# DR

Run _every_ command you have in mind in a Docker environment, avoiding installing binaries in your workstation.

This is not just an alias for `docker run`, because if an image is not found in official Docker Hub registry, it searches for 3-party images so that you can potentially run everything.

You can also define your own aliases for your preferred docker image and tag.

### Examples

Simple example

```bash
$ dr node
> [NODE_SHELL_HERE]
```

Using preferred version:

```bash
$ dr node@10
> [NODE_SHELL_HERE]

$ dr node@10-alpine
> [NODE_SHELL_HERE]
```

Other examples passing arguments:

```bash
$ dr php@7-alpine --version
PHP 7.2.12 (cli) (built: Nov 16 2018 03:17:59) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
```

Using an unofficial docker image:

```bash
$ dr sqlmap --url http://localhost
         _
 ___ ___| |_____ ___ ___  {1.0.9.32#dev}
|_ -| . | |     | .'| . |
|___|_  |_|_|_|_|__,|  _|
      |_|           |_|   http://sqlmap.org

Usage: python sqlmap.py [options]
```

### Define aliases

When you use `dr` the first time, it writes an entry into a local registry
to avoid searching into Docker Hub every time.

You can use this feature to define your own aliases.

To do so, edit the file `/usr/local/etc/dr.db`
and add/edit an entry in this format:

```
$ALIAS::${IMAGE}:${IMAGE_TAG}
```

Example:

```
php::php@7-alpine
```

### Installation

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kopiro/dr/master/install.sh)"
```

### License

MIT
