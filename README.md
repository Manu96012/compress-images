![macOS Supported](https://img.shields.io/badge/macOS-Supported-blue)
# compress-images  
A Bash script to compress a single image or more images contained in a directory.

## Compatibility
⚠️ This script is only compatible with **macOS** as it uses the `sips` command, which is specific to this operating system.

## Contributing  
Contributions are welcome! Please check our [Contributing Guidelines](CONTRIBUTING.md) before submitting changes.

## Security  
If you find a security vulnerability, please check our [Security Policy](.github/SECURITY.md) for reporting guidelines.  

## Installation  
1. Clone this repository into your preferred directory (recommended: **_/usr/local/bin/_**).  
2. Add an alias for the script:  
   - Check which shell you are using (Bash or Zsh) by running `echo $SHELL` in the terminal.  
   - Depending on the shell, add the alias to the **~/.bashrc** or **~/.zshrc** file.  
   - Set the alias as follows:  
     ```bash
     alias <desired-alias-name>="sh /path/to/file.sh"
     ```  

## Usage  
To use the script, call it via the alias, passing two arguments:  
1. **First argument**: the single image or the folder containing images (this is required).  
2. **Second argument**: the target extension for the compressed images (optional; if not specified, the original extension will be used).  

The script will create a **_compressed_** folder in the same location as the original images. Inside it, another folder will be created, named according to the target extension, containing all the compressed images.
