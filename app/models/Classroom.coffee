CocoModel = require './CocoModel'
schema = require 'schemas/models/classroom.schema'
utils = require 'core/utils'

module.exports = class Classroom extends CocoModel
  @className: 'Classroom'
  @schema: schema
  urlRoot: '/db/classroom'
  
  initialize: () ->
<<<<<<< HEAD
    @listenTo this, 'change:aceConfig', @capitalizeLanguageName
    super(arguments...)
    
  capitalizeLanguageName: ->
    language = this.get('aceConfig').language
    this.capitalLanguage = utils.capitalLanguages[language]
=======
    @listenTo @, 'change:aceConfig', @capitalizeLanguageName
    super(arguments...)
    
  capitalizeLanguageName: ->
    language = @get('aceConfig')?.language
    @capitalLanguage = utils.capitalLanguages[language]
>>>>>>> refs/remotes/codecombat/master

  joinWithCode: (code, opts) ->
    options = {
      url: _.result(@, 'url') + '/~/members'
      type: 'POST'
      data: { code: code }
    }
    _.extend options, opts
    @fetch(options)
    
  removeMember: (userID, opts) ->
    options = {
      url: _.result(@, 'url') + '/members'
      type: 'DELETE'
      data: { userID: userID }
    }
    _.extend options, opts
    @fetch(options)
