<<<<<<< HEAD
=======
_ = require 'lodash'
>>>>>>> refs/remotes/codecombat/master
utils = require '../lib/utils'
errors = require '../commons/errors'
wrap = require 'co-express'
Promise = require 'bluebird'
database = require '../commons/database'
mongoose = require 'mongoose'
<<<<<<< HEAD
Classroom = require '../classrooms/Classroom'
parse = require '../commons/parse'
LevelSession = require '../levels/sessions/LevelSession'
User = require '../users/User'

module.exports =
  getByOwner: wrap (req, res, next) ->
    ownerID = req.query.ownerID
=======
Classroom = require '../models/Classroom'
parse = require '../commons/parse'
LevelSession = require '../models/LevelSession'
User = require '../models/User'

module.exports =
  getByOwner: wrap (req, res, next) ->
    options = req.query
    ownerID = options.ownerID
>>>>>>> refs/remotes/codecombat/master
    return next() unless ownerID
    throw new errors.UnprocessableEntity('Bad ownerID') unless utils.isID ownerID
    throw new errors.Unauthorized() unless req.user
    throw new errors.Forbidden('"ownerID" must be yourself') unless req.user.isAdmin() or ownerID is req.user.id
<<<<<<< HEAD
    dbq = Classroom.find { ownerID: mongoose.Types.ObjectId(ownerID) }
    dbq.select(parse.getProjectFromReq(req))
    classrooms = yield dbq.exec()
=======
    sanitizedOptions = {}
    unless _.isUndefined(options.archived)
      # Handles when .archived is true, vs false-or-null
      sanitizedOptions.archived = { $ne: not (options.archived is 'true') }
    dbq = Classroom.find _.merge sanitizedOptions, { ownerID: mongoose.Types.ObjectId(ownerID) }
    dbq.select(parse.getProjectFromReq(req))
    classrooms = yield dbq
>>>>>>> refs/remotes/codecombat/master
    classrooms = (classroom.toObject({req: req}) for classroom in classrooms)
    res.status(200).send(classrooms)

  fetchMemberSessions: wrap (req, res, next) ->
    throw new errors.Unauthorized() unless req.user
    memberLimit = parse.getLimitFromReq(req, {default: 10, max: 100, param: 'memberLimit'})
    memberSkip = parse.getSkipFromReq(req, {param: 'memberSkip'})
    classroom = yield database.getDocFromHandle(req, Classroom)
    throw new errors.NotFound('Classroom not found.') if not classroom
    throw new errors.Forbidden('You do not own this classroom.') unless req.user.isAdmin() or classroom.get('ownerID').equals(req.user._id)
    members = classroom.get('members') or []
<<<<<<< HEAD
    members = members.slice(memberSkip, memberLimit)
    dbqs = []
    select = 'state.complete level creator'
    for member in members
      dbqs.push(LevelSession.find({creator: member.toHexString(), team: {$exists: false}}).select(select).exec())
=======
    members = members.slice(memberSkip, memberSkip + memberLimit)
    dbqs = []
    select = 'state.complete level creator playtime'
    for member in members
      dbqs.push(LevelSession.find({creator: member.toHexString()}).select(select).exec())
>>>>>>> refs/remotes/codecombat/master
    results = yield dbqs
    sessions = _.flatten(results)
    res.status(200).send(sessions)
    
  fetchMembers: wrap (req, res, next) ->
    throw new errors.Unauthorized() unless req.user
    memberLimit = parse.getLimitFromReq(req, {default: 10, max: 100, param: 'memberLimit'})
    memberSkip = parse.getSkipFromReq(req, {param: 'memberSkip'})
    classroom = yield database.getDocFromHandle(req, Classroom)
    throw new errors.NotFound('Classroom not found.') if not classroom
<<<<<<< HEAD
    throw new errors.Forbidden('You do not own this classroom.') unless req.user.isAdmin() or classroom.get('ownerID').equals(req.user._id)
    memberIDs = classroom.get('members') or []
    memberIDs = memberIDs.slice(memberSkip, memberLimit)
    
    dbqs = yield User.find({ _id: { $in: memberIDs }}).select(parse.getProjectFromReq(req)).exec()
    members = yield (user.toObject({ req: req, includedPrivates: ["name", "email"] }) for user in dbqs)
    
    res.status(200).send(members)
=======
    isOwner = classroom.get('ownerID').equals(req.user._id)
    isMember = req.user.id in (m.toString() for m in classroom.get('members'))
    unless req.user.isAdmin() or isOwner or isMember
      throw new errors.Forbidden('You do not own this classroom.')
    memberIDs = classroom.get('members') or []
    memberIDs = memberIDs.slice(memberSkip, memberSkip + memberLimit)
    
    members = yield User.find({ _id: { $in: memberIDs }}).select(parse.getProjectFromReq(req))
    memberObjects = (member.toObject({ req: req, includedPrivates: ["name", "email"] }) for member in members)
    
    res.status(200).send(memberObjects)
>>>>>>> refs/remotes/codecombat/master
