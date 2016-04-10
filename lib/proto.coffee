###*
 * Prototype Object
###
'use restrict'
EventEmitter = require 'events'
_ = require 'lodash'

class Object
  version       : '0.0.1'
  Bus           : new EventEmitter()

  createEvents  : ->
    # events
    console.log @events
    for event of @events
      @Bus.on event, @[event]  if typeof @[event] is 'function'
    @

  constructor:(@opts)->
    # replace metods and params
    @[n] = @opts[n] for n of @opts
    @createEvents()
    @

module.exports = Object