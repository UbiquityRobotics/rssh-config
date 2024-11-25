# Generating your own SSH key

> [!NOTE]  
> We recommend using ed25519 when generating your key

1. Open your terminal of choice
2. Run `ssh-keygen -t ed25519`
3. Your key should be located in `~/.ssh/`

> [!WARNING]  
> Make sure to send the `.pub` file. Do not share your private key with anyone.

For more info see [this link](https://www.ssh.com/academy/ssh/keygen) or [this link](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

If you are on Windows and the above don't work, see [this document](https://learn.microsoft.com/en-us/viva/glint/setup/sftp-ssh-key-gen)
