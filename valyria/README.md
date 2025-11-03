# Valyria
`valyria` is a lightweight utility written in Python which can encrypt and decrypt files.

## Features

- Given a file or directory, **Valyria** encrypts them using **256-bit AES** encryption and the **AES Key** is further protected by **RSA encryption**.
- Valyria requires that you set a password for your Private Key while encrypting which boosts its security further.

## Installation

### Using SSH or HTTPS

Clone the **ZAXNWare** repo using **SSH** or **HTTPS**:

```bash
git clone git@github.com:mozaxn/ZAXNWare.git
git clone https://github.com/mozaxn/ZAXNWare.git
```

Add executable permissions for `valyria`:

```bash
cd ZAXNWare/valyria
chmod +x valyria.py
```

**Optional:** You can install `valyria` system-wide:

```bash
sudo cp valyria.py /usr/local/bin/valyria
```
### Using ZAXNWare Installer

If you have **ZAXNWare Installer (zware)** downloaded, you can run:

```bash
sudo zware -i valyria
```
## Usage

### Basic Syntax
`valyria` requires a file or a directory and requires whether it is to be encrypted or decrypted.

```bash
valyria -d DIR --encrypt
```

Next, you are prompted for a password. **Make sure to save this password or you may lose your files permanently!**

This encrypts all the files in that directory and also generates a `VALYRIA_KEY.pem` file which your password-protected private key. Do not lose it!

For decryption, you need to specify the file/directory along with the private key file (ending in `.pem`):

```bash
valyria -d DIR --decrypt -p VALYRIA_KEY.pem
```

You are prompted for the password you set during the encryption. Once entered, the files are decrypted.

### Options

| **Option** | **Description**      |
|------------|----------------------|
| `-f` or `--file`   | The file which is to be encrypted/decrypted. |
| `-d` or `--dir`    | The directory which is to be encrypted/decrypted (including all subdirectories). |
| `-p` or `--privkey`| The file containing the private key. |
| `--encrypt`        | Encrypt the file/directory. |
| `--decrypt`        | Decrypt the file/directory. |
| `-v` or `--verbose`| Verbose output. |
| `--version`        | Display the current version of **Valyria**. | 
