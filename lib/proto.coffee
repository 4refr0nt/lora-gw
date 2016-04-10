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
  createEvents  : ->
    #@Bus.on e, @[e]  if typeof @[e] is 'function' for e of @events
    @

  constructor:(@opts)->
    # replace metods and params
    @[n] = @opts[n] for n of @opts
    # create new Bus
    @Bus =  new EventEmitter() unless  @Bus
    # init events
    @createEvents()
    @

module.exports = Object
