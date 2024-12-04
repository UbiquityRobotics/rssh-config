# RSSH Config

This document aims to provide some default configuration and commands for [Reverse-SSH](https://github.com/NHAS/reverse_ssh).
Full documentation available on the link.

For help with generating your own SSH key see [Generating your own SSH key](misc/sshkey.md)

## Using RSSH

To connect to the server:

- `ssh <SERVER_IP> -p 2222`

Below are some commands you may find useful.

- `help`: displays all available commands
- `connect HOST`: connects to a desired host
- `link -l`: lists currently generated links
- `link -r`: removes a link
- `link`: generates a bootstrapper link. Example: `link --goos linux --goarch arm --goarm 7 --name picontrol --garble --upx`
  - `name` will generate a named link instead of a hash. This may be preferred.
  - `--goos linux` sets the OS to linux
  - `--goarch arm --goarm 7` set the compiler to `arm7`, 32-bit. If 64 is required, use `--goarch arm64` instead.
  - `--garble --upx` obfuscate and pack the binary respectively.
  - This will automatically also generate `.sh`, `.py` and `.ps1` scripts. Just append your preferred extension to your path.
 
> [!IMPORTANT]  
> The link command works slightly differently, as nginx is set up to route anything sent to `/ctl`
> to the app. This means that if the server generates the link `http://192.168.0.11:3232/4bb55de4d50cc724afbf89cf46f17d25`,
> it will be accessible on `https://192.168.0.11/ctl/4bb55de4d50cc724afbf89cf46f17d25`. Make sure you don't
> forget to remove the port and add `https` instead of `http`. Never use `http`.

If you want to connect to a client, you can also use the following:

- `ssh -J <SERVER_IP>:2222 <client_id>`: connects to a remote host using RSSH as a jump server
- `scp -J <SERVER_IP>:2222 <client_id>:/etc/passwd`: downloads a file using `scp`
- `ssh -D 9050 -J <SERVER_IP>:2222 <client_id>`: sets up dynamic port forwarding

## Setting up

Pull the git repository on a server of your choice. `cd` into the folder and run `docker-compose up --build -d`

> [!NOTE]  
> The following command will create a folder `/etc/docker/compose/rssh` and copy the compose file to it.
> Changes to your local file will not affect the installed service.

If you're running it for the first time, run `make letsencrypt` to generate an SLL certificate. If you
already have a cetificate, run `make generate_dhparam` instead.

To install as a service, use `make install`.

## Adding access

Create a file in `data/keys`. The filename will be a user's username, the contents will be used as `authorized_keys`. To create an administrator see `data/authorized_controllee_keys`
