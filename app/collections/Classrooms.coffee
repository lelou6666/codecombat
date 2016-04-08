Classroom = require 'models/Classroom'
CocoCollection = require 'collections/CocoCollection'

module.exports = class Classrooms extends CocoCollection
  model: Classroom
  url: '/db/classroom'
  
  initialize: ->
<<<<<<< HEAD
    @on 'sync', ->
=======
    @on 'sync', =>
>>>>>>> refs/remotes/codecombat/master
      for classroom in @models
        classroom.capitalizeLanguageName()
    super(arguments...)

  fetchMine: (options={}) ->
    options.data ?= {}
    options.data.ownerID = me.id
    @fetch(options)
