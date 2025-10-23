# CPUMon (CPU Monitor)

`cpumon` is a lightweight Linux utility for monitoring CPU usage in real-time.  
It alerts the user when the CPU usage exceeds a certain value.

## Features

- Monitors the CPU usage in real-time.
- Sends a system notification when the CPU usage exceeds a certain value.
- Can `echo` alerts directly to the terminal.

## Installation

### Using SSH or HTTPS

Clone the **ZAXNWare** repo using **SSH** or **HTTPS**:

```bash
git clone git@github.com:ZAXN/ZAXNWare.git
git clone https://github.com/mozaxn/ZAXNWare.git
```

Add executable permissions for `cpumon`:

```bash
cd ZAXNWare/cpumon
chmod +x cpumon.sh
```

**Optional:** You can install `cpumon` system-wide:

```bash
sudo cp cpumon.sh /usr/local/bin/cpumon
```
### Using ZAXNWare Installer

If you have **ZAXNWare Installer (zware)** downloaded, you can run:

```bash
sudo zware -i cpumon
```
## Usage

### Basic Syntax
`cpumon` requires the CPU usage upper limit to be given using the `-u` option:

```bash
cpumon -u [cpu-usage]
```
CPU Usage must be given as a percentage. For instance:

```bash
cpumon -u 80
```

### Other Options

| **Option** | **Description**      |
|------------|----------------------|
| `-t`       | Display a warning in the terminal if the limit is exceeded. |
| `-n`       | Send a system notification when the limit is exceeded. |
| `-i`       | The interval in seconds after the CPU usage is to be checked. If `-i` is not specified, the default interval is taken as 10 seconds. Usage: `-i [seconds]` |