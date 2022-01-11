# wireguard-pia - Docker mod for linuxserver/docker-wireguard

## WIP - NOT SUPPORTED

This is a slightly edited version of the scripts in the https://github.com/pia-foss/manual-connections/ repo.

It will automatically create a wg0.conf file in /config

## Usage

Here are some example snippets to help you get started creating a container with the mod.

### docker-compose (recommended, [click here for more info](https://docs.linuxserver.io/general/docker-compose))

```yaml
---
version: "2.1"
services:
  wireguard_client:
    image: lscr.io/linuxserver/wireguard
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - DOCKER_MODS=ghcr.io/linuxserver-labs/wireguard-pia
      - PIA_USER=p123456
      - PIA_PASS=password
      - LAN_NETWORK=192.168.0.0/24,172.17.0.0/16 # Comma separated values
    volumes:
      - /path/to/appdata/config:/config
      - /lib/modules:/lib/modules
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
      - net.ipv6.conf.all.disable_ipv6=1
      - net.ipv6.conf.default.disable_ipv6=1
    restart: unless-stopped
```

### docker cli ([click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=wireguard_client \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e DOCKER_MODS=ghcr.io/linuxserver-labs/wireguard-pia \
  -e PIA_USER=p123456 \
  -e PIA_PASS=password \
  -e LAN_NETWORK=192.168.0.0/24,172.17.0.0/16 `# Comma separated values` \
  -v /path/to/appdata/config:/config \
  -v /lib/modules:/lib/modules \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv6.conf.all.disable_ipv6=1" \
  --sysctl="net.ipv6.conf.default.disable_ipv6=1" \
  --restart unless-stopped \
  lscr.io/linuxserver/wireguard
```

## Parameters

| Parameter | Function |
| :----: | --- |
| `-e PIA_USER=p123456` | Your PIA username |
| `-e PIA_PASS=password` | Your PIA password |
| `-e LAN_NETWORK=192.168.0.0/24,172.17.0.0/16` | Comma separated values. Creates the PostUp and PreDown commands with the supplied values. |
| `-e MAX_LATENCY=0.05` | numeric value, in seconds # Optional Default is 0.05 |
| `-e PREFERRED_REGION` | The region ID for a PIA server. If called without specifying `PREFERRED_REGION` this script writes a list of servers within lower than `MAX_LATENCY` to `/opt/piavpn-manual/latencyList` for reference, and auto-selects the server with the lowest latency |
