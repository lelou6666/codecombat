config = require '../../../server_config'
require '../common'
clientUtils = require '../../../app/core/utils' # Must come after require /common
<<<<<<< HEAD
mongoose = require 'mongoose'
utils = require '../utils'
_ = require 'lodash'
Promise = require 'bluebird'
=======
utils = require '../utils'
_ = require 'lodash'
Promise = require 'bluebird'
request = require '../request'
>>>>>>> refs/remotes/codecombat/master
requestAsync = Promise.promisify(request, {multiArgs: true})

campaignURL = getURL('/db/campaign')

<<<<<<< HEAD
=======
Campaign = require '../../../server/models/Campaign'

>>>>>>> refs/remotes/codecombat/master
describe '/db/campaign', ->
    
  beforeEach utils.wrap (done) ->
    yield utils.clearModels([Campaign])
    @heroCampaign1 = yield new Campaign({name: 'Hero Campaign 1', type: 'hero'}).save()
    @heroCampaign2 = yield new Campaign({name: 'Hero Campaign 2', type: 'hero'}).save()
    @courseCampaign1 = yield new Campaign({name: 'Course Campaign 1', type: 'course'}).save()
    @courseCampaign2 = yield new Campaign({name: 'Course Campaign 2', type: 'course'}).save()
    done()
    
<<<<<<< HEAD
  describe 'GET /db/campaign?type=:type', ->
    it 'returns an array of classrooms with the given owner', utils.wrap (done) ->
=======
  describe 'GET campaigns of a certain type', ->
    it 'returns only that type', utils.wrap (done) ->
>>>>>>> refs/remotes/codecombat/master
      [res, body] =  yield request.getAsync getURL('/db/campaign?type=course'), { json: true }
      expect(res.statusCode).toBe(200)
      expect(body.length).toBe(2)
      for campaign in body
        expect(campaign.type).toBe('course')
      done()

<<<<<<< HEAD
  describe 'GET /db/campaign', ->              
    it 'returns an array of classrooms with the given owner', utils.wrap (done) ->
      [res, body] =  yield request.getAsync getURL('/db/campaign'), { json: true }
      expect(res.statusCode).toBe(200)
      expect(body.length).toBe(4)
      done()
=======
  describe 'GET all campaigns', ->
    it 'returns all of them regardless of type', utils.wrap (done) ->
      [res, body] =  yield request.getAsync getURL('/db/campaign'), { json: true }
      expect(res.statusCode).toBe(200)
      expect(body.length).toBe(4)
      done()
>>>>>>> refs/remotes/codecombat/master
