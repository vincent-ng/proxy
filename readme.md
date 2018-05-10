# proxy

This repo has two proxy servers.
One is socks5 proxy based on ssh and sshd.
Another is http/https proxy based on nodejs.

## Usage

### socks5
```bash
docker run -it -p 1080:1080 vincent/proxy
```

or

```bash
docker-compose -f docker-compose.yml up
```

### http/https

```bash
docker run -it -p 8123:80 vincent/proxy:nodejs
```

or

```bash
docker-compose -f docker-compose-http.yml up
```

## Online Demo

### socks5
[![Try in PWD](https://github.com/play-with-docker/stacks/raw/cff22438cb4195ace27f9b15784bbb497047afa7/assets/images/button.png)](https://labs.play-with-docker.com?stack=https://raw.githubusercontent.com/vincentngthu/socks-proxy/master/docker-compose.yml)

### http/https
[![Try in PWD](https://github.com/play-with-docker/stacks/raw/cff22438cb4195ace27f9b15784bbb497047afa7/assets/images/button.png)](https://labs.play-with-docker.com?stack=https://raw.githubusercontent.com/vincentngthu/socks-proxy/master/docker-compose-http.yml)
