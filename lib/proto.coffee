###*
 * Prototype Object
###
'use restrict'
EventEmitter = require 'events'

class Object
  version       : '0.0.1'
  Bus           : new EventEmitter()
  ###*
   * [createEvents]
   * @return {object} [this]
   * events:
   *   test: 'test'
   * on emit 'test' call @test()
  ###
  createEvents  : ->
    for event of @events
      @Bus.on event, @[event]  if typeof @[event] is 'function'
    @

  constructor:(@opts)->
    # replace metods and params
    @[n] = @opts[n] for n of @opts
    @createEvents()
    @

module.exports = Object