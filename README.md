# DR

Run _every_ command in a Docker environment, avoiding installing binaries in your workstation.

Furthermore, if an image is not found in official Docker Hub registry, it searches for 3-party images - do that you can potentially run everything.

### Examples

Simple example

```bash
drun node --version
```

Using preferred version:

```bash
drun php@7 --version
```

Using a more specific (docker) tag:

```bash
drun php@7-alpine --version
```

Using an unofficial docker image:

```bash
drun sqlmap --url http://localhost
```

### Installation

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/kopiro/dr/master/install.sh)"
```
