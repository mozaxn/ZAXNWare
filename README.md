# ZAXNWare

![GitHub License](https://img.shields.io/github/license/mozaxn/ZAXNWare)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/mozaxn/ZAXNWare)
![GitHub last commit](https://img.shields.io/github/last-commit/mozaxn/ZAXNWare)
![GitHub top language](https://img.shields.io/github/languages/top/mozaxn/ZAXNWare)

ZAXNWare is a collection of lightweight Linux utilities created by **ZAXN**.
These are small, efficient command-line tools for everyday tasks.

## Utilities Included

| Tool       | Description       |
|------------|-------------------|
| **zwc**    | Counts words, lines or bytes in a file. |
| **bakman** | Creates backup files for a directory, preserves structure, compresses into `.tar.gz` |
| **cpumon** | Monitors CPU usage in the background and sends a system notification when usage exceeds a threshold |

## Installation

**You can install individual tools using `zware.sh` script.**

### Using ZAXNWare Installer

You can downnload `zware.sh` using `curl`:

```bash
curl -L https://raw.githubusercontent.com/mozaxn/ZAXNWare/main/zware.sh -o zware.sh
chmod +x zware.sh
```

To install `zware` system-wide (for the current user):

```bash
sudo mv ./zware.sh /usr/local/bin/zware
```

To download a tool, run:

```bash
sudo zware -i <tool>
```

For instance, to download `bakman`, run:

```bash
sudo zware -i bakman
```

To view the list of available tools in ZAXNWare, run:

```bash
zware -l
```

### Using SSH
```bash
git clone git@github.com:mozaxn/ZAXNWare.git
```
*Using SSH requires you to have an SSH key added to your GitHub account.*

### Using HTTPS
```bash
git clone https://github.com/mozaxn/ZAXNWare.git
```