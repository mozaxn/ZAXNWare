# ZAXNWare Counter

`zwc` is a lightweight Linux utility for counting various metrics of a file (e.g words, lines and bytes)

## Features

- Counts the lines in a file.
- Counts the words in a file.
- Prints the size of a file in bytes.

## Installation

### Using SSH or HTTPS

Clone the **ZAXNWare** repo using **SSH** or **HTTPS**:

```bash
git clone git@github.com:ZAXN/ZAXNWare.git
git clone https://github.com/mozaxn/ZAXNWare.git
```

Add executable permissions for `zwc`:

```bash
cd ZAXNWare/zwc
chmod +x zwc.sh
```

**Optional:** You can install `zwc` system-wide:

```bash
sudo cp cpumon.sh /usr/local/bin/zwc
```
### Using ZAXNWare Installer

If you have **ZAXNWare Installer (zware)** downloaded, you can run:

```bash
sudo zware -i zwc
```
## Usage

### Basic Syntax
`zwc` requires a file name to return the metrics. The file name is specified using the `-f` option. If no other options are mentioned, word count will be returned:

```bash
zwc -f [file]
```

### Other Options

| **Option** | **Description**      |
|------------|----------------------|
| `-w`       | Display the word count. |
| `-l`       | Display the number of lines. |
| `-b`       | Display the size of the file in bytes. |
| `-a`       | Same as `-lbw`. All metrics are shown. |
| `-v`       | Prints the current version of `zwc`.   |