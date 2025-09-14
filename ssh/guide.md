# Generating a new SSH key

## ssh-keygen – OpenSSH authentication key utility

```bash
# Generate an ed25519 key with 32 key derivation function rounds and save the key to a specific file:
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "example@gmail.com"
```

## ssh-keygen – OpenSSH authentication agent

```bash
# Need to check ssh-agent `echo "$SSH_AUTH_SOCK"` before Start the ssh-agent in the background.
eval (ssh-agent -s)
```

## ssh-add – adds private key identities to the OpenSSH authentication agent

```bash
# List fingerprints of currently loaded keys:
ssh-add -l

# Add your SSH private key to the ssh-agent and store your passphrase in the keychain.
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Delete a key from the ssh-agent:
ssh-add --apple-use-keychain -d ~/.ssh/id_ed25519
```

## ssh-copy-id – use locally available keys to authorise logins on a remote machine

```bash
# Copy the given public key to the remote with specific port:
ssh-copy-id -i ~/.ssh/id_ed25519.pub -p port username@remote_host
```

# Git remote repository

## Adding a new SSH key to your GitHub account

```bash
# Copy the SSH public key to your clipboard.
pbcopy < ~/.ssh/id_ed25519.pub
```

## Testing your SSH connection

```bash
ssh -T git@github.com
```

## Git remote

```bash
# Add a remote
git remote add remote_name remote_url

# Change the URL of a remote (use `--add` to keep the existing URL):
git remote set-url remote_name new_url
```
