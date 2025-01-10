# Generating a new SSH key
```bash
# Generating key
ssh-keygen -t ed25519 -C "example@gmail.com"

# Start the ssh-agent in the background.
eval (ssh-agent -c)

# Add your SSH private key to the ssh-agent and store your passphrase in the keychain.
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

# Adding a new SSH key to your GitHub account
```bash
# Copy the SSH public key to your clipboard.
pbcopy < ~/.ssh/id_ed25519.pub
```

# Testing your SSH connection
```bash
ssh -T git@github.com
```

# Add new remote git

```bash
git remote add new-origin git@github.com:hungvx-dev/Dotfiles.git
```

# Update remote git

```bash
git remote set-url origin git@github.com:hungvx-dev/Dotfiles.git
```
