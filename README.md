# DR

Run _every_ command in a Docker environment, avoiding installing binaries in your workstation.

Furthermore, if an image is not found in official Docker Hub registry, it searches for 3-party images - do that you can potentially run everything.

You can also define your own aliases for your preferred images.

### Examples

Simple example

```bash
$ dr php --version
PHP 7.2.12 (cli) (built: Nov 16 2018 03:17:59) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
```

Using preferred version:

```bash
$ dr php@7 --version
PHP 7.2.12 (cli) (built: Nov 16 2018 03:17:59) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
```

Using a more specific (docker) tag:

```bash
$ dr php@7-alpine --version
PHP 7.2.12 (cli) (built: Nov 16 2018 03:17:59) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
```

Using an unofficial docker image:

```bash
$ dr sqlmap --url http://localhost
...
```

### Installation

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kopiro/dr/master/install.sh)"
```
