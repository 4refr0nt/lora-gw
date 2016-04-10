dgram = require('dgram')

udpServer = (config)->
  server = dgram.createSocket('udp4')
  server.on 'listening', ->
    address = server.address()
    console.log 'UDP Server listening on ' + address.address + ':' + address.port
    return
  server.on 'message', (message, remote) ->
    console.log remote.address + ':' + remote.port + ' - ' + message
    return
  server.bind config.PORT, config.HOST
  server

# test
udpServer
  PORT: 20000
  HOST: '127.0.0.1'

module.exports = udpServer