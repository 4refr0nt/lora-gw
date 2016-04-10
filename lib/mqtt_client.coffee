###*
 * Mqtt Client
###
mqtt = require('mqtt')

mqttClient = (config)->
  client = mqtt.connect( config.URL )

  client.on 'connect', ->
    for t in config.SUBCRIBE
      client.subscribe t
      client.publish 'test', 'Hello mqtt'

  client.on 'message', (topic, message) ->
    # message is Buffer
    console.log message.toString()
    client.end()

# test
c = mqttClient
  SUBSCRIBE:['config', 'test']
  URL: 'mqtt://test.mosquitto.org'