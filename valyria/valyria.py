#!/usr/bin/env python3

import argparse
import os
from getpass import getpass
from cryptography.hazmat.primitives.asymmetric import padding, rsa
from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes

# Important variables
VERSION = "1.0.0"

def generate_private_key(outfile:str, password:str) -> bytes:

    """Generates a password protected PRIVATE KEY"""
    
    # Key parameters
    SIZE = 4096
    PUBLIC_EXPONENT = 65537
    OUTFILE = f"{outfile}.pem"

    # Check the password
    if not password:
        raise SystemError("A password is required! Aborting...")
    
    password = password.encode('utf-8')

    # Generate RSA Key
    private_key = rsa.generate_private_key(PUBLIC_EXPONENT, SIZE)
    public_key = private_key.public_key()


    # Encryption and Serialization
    priv_key = private_key.private_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PrivateFormat.TraditionalOpenSSL,
        encryption_algorithm=serialization.BestAvailableEncryption(password)
    )

    pub_key = public_key.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    )

    # Write the private key to a file
    with open(OUTFILE, 'wb') as f:
        f.write(priv_key)

    # Return the public key
    return pub_key


def encrypt(file:str, public_key:bytes) -> None:

    """Encrypts a given file using the public key."""

    INPUT_FILE = file

    public_key = serialization.load_pem_public_key(public_key)

    # Generate a random AES Key and IV
    aes_key = os.urandom(32)   # AES-256
    iv = os.urandom(16)        # 128-bit IV

    # Encrypt the files using the AES key
    with open(INPUT_FILE, "rb") as f:
        plaintext = f.read()

    # Encrypt the contents of the file
    cipher = Cipher(algorithms.AES(aes_key), modes.CFB(iv))
    encryptor = cipher.encryptor()
    ciphertext = encryptor.update(plaintext) + encryptor.finalize()

    # Encrypt the AES Key
    encrypted_key = public_key.encrypt(
        aes_key,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    # Save the encrypted outputs
    with open(INPUT_FILE, "wb") as f:
        f.write(iv)
        f.write(ciphertext)
        f.write(encrypted_key)

def decrypt(file:str, private_key_file:str, password:str) -> None:

    """Decrypt a file using the private key and the password."""

    # Load the private key
    with open(private_key_file, 'rb') as f:
        private_key = serialization.load_pem_private_key(f.read(), password.encode('utf-8'))
    
    rsa_size = private_key.key_size
    rsa_enc_size = (rsa_size+7) // 8
    
    # Read the IV, ciphertext and AES Key (encrypted)
    with open(file, 'rb') as f:
        
        f.seek(-rsa_enc_size, 2)
        aes = f.read(rsa_enc_size)

        f.seek(0)
        iv = f.read(16)
        
        ciphertext = f.read(os.path.getsize(file) - 16 - rsa_enc_size)
    
    # Decrypt the AES Key
    aes_key = private_key.decrypt(
        aes,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    # Decrypt the contents
    cipher = Cipher(algorithms.AES(aes_key), modes.CFB(iv))
    decryptor = cipher.decryptor()
    plaintext = decryptor.update(ciphertext) + decryptor.finalize()


    with open(file, 'wb') as f:
        f.write(plaintext)

def main():

    """Main function invoked when Valyria is run from CLI."""

    # Create a parser
    parser = argparse.ArgumentParser()

    # Add arguments to the parser
    parser.add_argument("-f", "--file", required=False, help="Path of the file.")
    parser.add_argument("-d", "--dir", required=False, help="Path to directory.")
    parser.add_argument("-p", "--privkey", required=False, help="Path to the file containing private key.")
    parser.add_argument("--encrypt", required=False, action="store_true", help="If the directory/file is to encrypted.")
    parser.add_argument("--decrypt", required=False, action="store_true", help="If the directory/file is to decrypted.")
    parser.add_argument("-v", "--verbose", required=False, action="store_true", help="Verbose output.")
    parser.add_argument("--version", required=False, action="store_true", help="Display the current version of Valyria.")

    # Parse the arguments
    args = parser.parse_args()

    # Assign arguments to variables
    file = args.file
    directory = args.dir
    private_key = args.privkey
    verbose = args.verbose
    encryption = args.encrypt
    decryption = args.decrypt
    version = args.version

    # Return version if asked for
    if version:
        print(f"ZAXNWare Valyria version {VERSION}")
        return

    # If encryption/decryption is not mentioned, return an error
    if (not encryption) and (not decryption):
        print("Specify whether encryption or decryption is to be performed.")
        return False

    # If both -f and -d are passed, return an error
    if not ((not file and directory) or (file and not directory)):
        print("Either specify a directory or a file.")
        return False
    
    # If decryption is to be performed but no private key has been specified
    if decryption and not private_key:
        print("Please specify a private key file.")
        return False

    # ENCRYPTION
    if encryption:

        # Password confirmation
        password = getpass("Enter a password for encryption: ")
        if getpass("Re-enter your password: ") != password:
            print("Passwords do not match! Please try again.")
            return False

        # Generate a private key and return the public key 
        pubkey = generate_private_key("VALYRIA_KEY", password)

        if file:
            encrypt(file, pubkey)

            if verbose:
                print(f"Encrypted file --> {file}")
        
        elif directory:

            all_files = list()
            for root, dir, files in os.walk(directory):

                for file in files:
                    all_files.append(os.path.join(root, file))
            
            for file in all_files:
                encrypt(file, pubkey)

                if verbose:
                    print(f"Encrypted file --> {file}")

    # DECRYPTION
    elif decryption:

        password = getpass("Enter the password for the private key: ")
        
        if file:
            decrypt(file, private_key, password)

            if verbose:
                print(f"Decrypted file --> {file}.")
        
        elif directory:

            all_files = list()
            for root, dir, files in os.walk(directory):
                
                for file in files:
                    all_files.append(os.path.join(root, file))
            
            for file in all_files:
                decrypt(file, private_key, password)

                if verbose:
                    print(f"Decrypted file --> {file}.")

if __name__ == "__main__":
    main()