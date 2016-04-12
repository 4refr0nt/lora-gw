###*
  **     **    ***    ********  ********  **      **    ***    ********
  **     **   ** **   **     ** **     ** **  **  **   ** **   **     **
  **     **  **   **  **     ** **     ** **  **  **  **   **  **     **
  ********* **     ** ********  **     ** **  **  ** **     ** ********
  **     ** ********* **   **   **     ** **  **  ** ********* **   **
  **     ** **     ** **    **  **     ** **  **  ** **     ** **    **
  **     ** **     ** **     ** ********   ***  ***  **     ** **     **
 *
 * @author Victor Brutskiy <4refr0nt@gmail.com>
 * @author Alex Suslov <suslov@me.com>
 * @copyright 2016
 * @license MIT
###
'use restrict'

Proto   = require './proto'

class Hardware extends Proto
  initialize: (@config)->
    console.log  'Hardware: Init...', @config
    @


module.exports = Hardware
