# Backup Man

`bakman` is a lightweight Linux utility for creating backups of directories.  
It preserves the directory structure, creates `.bak` copies of files, and compresses everything into a `.tar.gz` archive (if option is specified).

## Features

- Backup all files in a directory.
- Preserve directory structure.
- Compress backup into `.tar.gz`.
- Simple command-line interface.
- Safe: original files are untouched.

## Installation

### Using SSH or HTTPS

Clone the **ZAXNWare** repo using **SSH** or **HTTPS**:

```bash
git clone git@github.com:ZAXN/ZAXNWare.git
git clone https://github.com/mozaxn/ZAXNWare.git
```

Add executable permissions for `bakman`:

```bash
cd ZAXNWare/bakman
chmod +x bakman.sh
```

**Optional:** You can install `bakman` system-wide:

```bash
sudo cp bakman.sh /usr/local/bin/bakman
```
### Using ZAXNWare Installer

If you have **ZAXNWare Installer (zware)** downloaded, you can run:

```bash
sudo zware -i bakman
```
## Usage

### Basic Syntax
`bakman` requires a file or directory to be specified for backing up. For files, use:

```bash
bakman -f [file]
```

For directories, use:

```bash
bakman -d [directory]
```

### Other Options

| **Option** | **Description**      |
|------------|----------------------|
| `-k`       | Archive the backed up files into a `.tar`. |
| `-z`       | Create a compressed archive of the backed up files as `.tar.gz`. `-k` option need not be used. |
| `-r`       | Remove the backup files after archiving or compressing them. Only takes effect when used with `-k` or `-z` options. |
| `-v`       | Verbose output. |