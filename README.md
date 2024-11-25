# RSSH Config

This document aims to provide some default configuration and commands for [Reverse-SSH](https://github.com/NHAS/reverse_ssh).
Full documentation available on the link.

## Using RSSH

> [!CAUTION]
> The client download links are HTTP and could potentially be intercepted and the contents modified.
> TLS is not supported by default. HTTPS has to be configured externally, like via NGINX (WIP)
> For more information see [man in the middle](https://en.wikipedia.org/wiki/Man-in-the-middle_attack)

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
 
If you want to connect to a client, you can also use the following:

- `ssh -J <SERVER_IP>:2222 <client_id>`: connects to a remote host using RSSH as a jump server
- `scp -J <SERVER_IP>:2222 <client_id>:/etc/passwd`: downloads a file using `scp`
- `ssh -D 9050 -J <SERVER_IP>:2222 <client_id>`: sets up dynamic port forwarding

## Setting up

Pull the git repository on a server of your choice. `cd` into the folder and run `docker-compose up -d`

> [!NOTE]  
> The following command will create a folder `/etc/docker/compose/rssh` and copy the compose file to it.
> Changes to your local file will not affect the installed service.

To install as a service, use `make install`.

## Adding access

Create a file in `data/keys`. The filename will be a user's username, the contents will be used as `authorized_keys`. To create an administrator see `data/authorized_controllee_keys`
