# File_Encryption-Decryption


A simple command-line tool for encrypting and decrypting files using AES128 encryption.

## Introduction

File-Encryption-Decryption Tool provides a secure way to encrypt and decrypt files using the Advanced Encryption Standard (AES) algorithm with a key size of 128 bits. It is designed to be a user-friendly command-line tool for protecting sensitive data.

## Features

- **AES128 Encryption**: Utilizes the AES128 encryption algorithm for secure file encryption.
- **User-Friendly Interface**: Simple command-line interface for easy interaction.
- **File-Based Encryption/Decryption**: Encrypt and decrypt individual files easily.
- **Key Input**: Allows users to input encryption/decryption keys.


## Installation

1. Make sure you have Haskell and Cabal installed on your system.

2. Clone the repository:

 
   git clone https://github.com/FaizanShaikh-3033/File_Encryption-Decryption.git
   
Navigate to the project directory:

  ->  cd File_Encryption-Decryption

Build the project using Cabal:

   ->  cabal build

Running the Code
After building the project, you can run the executable:

  -> cabal run

Follow the on-screen instructions to choose encryption, decryption, or exit options.

-For encryption, provide the file path, and a secret key when prompted.

-For decryption, provide the encrypted file path and the same secret key used for encryption.

-The tool will display messages indicating whether the operation was successful.

-To exit the tool, choose the "3. Exit" option.

-Feel free to customize the code and adapt it to your specific needs.
