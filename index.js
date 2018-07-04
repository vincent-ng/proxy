const request = require('request')
const http = require("http")
const url = require("url")
const net = require('net')
const httpProxy = require('http-proxy')

let server

if (process.env.TARGET) {
	const hostMap = JSON.parse(process.env.TARGET)
	const proxy = httpProxy.createProxyServer({ changeOrigin: true })
	server = http.createServer((req, res) => {
		const src = req.headers.host + req.url
		const target = hostMap[src] || hostMap[req.headers.host]
		if (!target) {
			res.end('Hello proxy user!')
			return
		}
		console.log(`Proxy HTTP request for: ${src} -> ${target}${req.url}`)
		proxy.web(req, res, { target })
	})
} else {
	server = http.createServer((req, res) => {
		const { protocol, host } = url.parse(req.url)
		if (!protocol || !host) {
			res.end('Hello proxy user!')
			return
		}
		console.log(`Proxy HTTP request for: ${protocol}//${host}`)
		req.pipe(request(req.url)).pipe(res)
	})

	server.addListener('connect', (req, socket, bodyhead) => {
		const [hostDomain, hostPort] = req.url.split(':')
		console.log(`Proxy HTTPS request for: ${hostDomain}:${hostPort}`)

		const proxySocket = new net.Socket()
		proxySocket.connect(hostPort, hostDomain, function () {
			proxySocket.write(bodyhead)
			socket.write(`HTTP/${req.httpVersion} 200 Connection established\r\n\r\n`)

			proxySocket.pipe(socket)
			socket.pipe(proxySocket)
		}).on('error', console.error)
	})
}

server.listen(process.env.PORT || 80)
