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

If TARGET env var is porvided, proxy traffic according to the host map.
If TARGET env var is empty, act as a common proxy server.

```bash
$env:TARGET='{"baidu.localhost:8080":"https://www.baidu.com", "google.localhost:8080":"https://www.google.com"}'
node .
```

TARGET config example.

```json
{
	"localhost:8080/helloworld":"https://wt-18e127c6f4b8a13508b25fa5c646c8a2-0.sandbox.auth0-extend.com/hello/world",
	"localhost:8080/":"https://wt-18e127c6f4b8a13508b25fa5c646c8a2-0.sandbox.auth0-extend.com/index.html",
	"localhost:8080":"https://wt-18e127c6f4b8a13508b25fa5c646c8a2-0.sandbox.auth0-extend.com",
	"baidu.localhost:8080":"https://www.baidu.com",
	"google.localhost:8080":"https://www.google.com"
}
```

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
