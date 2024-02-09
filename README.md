# sysconf

### Overview
This bash script automates the setup and installation of essential tools and applications on my Linux system.

## Prerequisites
- A Debian-based operating system
- Bash shell

## Usage
1. Open a terminal.

2. Clone the repository:
   ```bash
   git clone https://github.com/0xAFz/sysconf.git
   ```

3. Navigate to the script directory:
   ```bash
   cd sysconf
   ```

4. Make the script executable:
   ```bash
   sudo chmod +x setup.sh
   ```

5. Run the script:
   ```bash
   sudo ./setup.sh
   ```

## Configuration
The script performs the following actions:

- Installs essential tools: vim, git, curl, and wget.
- Installs zsh and Oh My Zsh with autosuggestions plugin.
- Installs golang.
- Installs pentest tools: subfinder, x8, ffuf, dnsx, httpx.

## Notes
- Ensure that your user account has sudo privileges.
- Review the script content before execution to understand the actions it performs.

**Disclaimer:** Use this script at your own risk. It is recommended to review and understand the commands before running the script on your system.
