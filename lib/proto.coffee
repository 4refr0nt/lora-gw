###*
 * Prototype Object
###
'use restrict'
EventEmitter = require 'events'

class Object
  version       : '0.0.1'
  ###*
   * [createEvents]
   * @return {object} [this]
   * events:
   *   test: 'test'
   * on emit 'test' call @test()
  ###
  createEvents : ->
    for e of @events
      fn = @[ @events[e] ]
      # console.log "typeof @['#{fn}']", typeof fn
      if fn and typeof fn is 'function'
        @Bus.on e, fn
      else
        @Bus.emit 'Logger', "No #{@events[e]} function", 0
    @


  constructor:( config )->
    # create new Bus
    @Bus =  new EventEmitter() unless @Bus
    # init events
    @createEvents()
    # init
    @initialize( config ) if @initialize and typeof @initialize is 'function'
    @

module.exports = Object
