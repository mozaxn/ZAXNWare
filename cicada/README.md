# Cicada
`cicada` is a lightweight Linux utility for creating a script which install packages from `apt` repository in bulk.

## Features

- Given a list of packages, **Cicada** creates a shell script which when executed downloads all the packages at once.
- This prevents repetitive tasks especially when switching between machines.

## Installation

### Using SSH or HTTPS

Clone the **ZAXNWare** repo using **SSH** or **HTTPS**:

```bash
git clone git@github.com:ZAXN/ZAXNWare.git
git clone https://github.com/mozaxn/ZAXNWare.git
```

Add executable permissions for `cicada`:

```bash
cd ZAXNWare/cicada
chmod +x cicada.sh
```

**Optional:** You can install `cicada` system-wide:

```bash
sudo cp cicada.sh /usr/local/bin/cicada
```
### Using ZAXNWare Installer

If you have **ZAXNWare Installer (zware)** downloaded, you can run:

```bash
sudo zware -i cicada
```
## Usage

### Basic Syntax
`cicada` requires a file containing packages and a name for the shell script it creates. For instance,

```bash
cicada -p packages.txt -s script.sh
```

This generates a `script.sh` file which has executable permissions already given to it.

### Other Options

| **Option** | **Description**      |
|------------|----------------------|
| `-n`       | Prevents `sudo apt update` from running when executing the created script. |