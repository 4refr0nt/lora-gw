###*
 * Udp Client send
###
dgram = require('dgram')

udpClient = (config)->
  message = new Buffer config.MESSAGE
  client = dgram.createSocket('udp4')
  client.send message, 0, message.length, config.PORT, config.HOST, (err, bytes) ->
    throw err if err
    console.log 'UDP message sent to ' + config.HOST + ':' + config.PORT
    client.close()

# test
c = udpClient
  PORT: 20000
  HOST: '127.0.0.1'
  MESSAGE: 'Udp Client send Data'