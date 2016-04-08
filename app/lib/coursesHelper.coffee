<<<<<<< HEAD
module.exports = 
=======
module.exports =
>>>>>>> refs/remotes/codecombat/master
  # Result: Each course instance gains a property, numCompleted, that is the
  #   number of students in that course instance who have completed ALL of
  #   the levels in thate course
  calculateDots: (classrooms, courses, courseInstances, campaigns) ->
    for classroom in classrooms.models
      # map [user, level] => session so we don't have to do find TODO
      for course, courseIndex in courses.models
<<<<<<< HEAD
        instance = courseInstances.getByCourseAndClassroom(course, classroom)
        continue if not instance
        instance.numCompleted = 0
        campaign = campaigns.get(course.get('campaignID'))
        for userID in instance.get('members')
          allComplete = _.every campaign.getNonladderLevels().models, (level) ->
=======
        instance = courseInstances.findWhere({ courseID: course.id, classroomID: classroom.id })
        continue if not instance
        instance.numCompleted = 0
        instance.numStarted = 0
        campaign = campaigns.get(course.get('campaignID'))
        for userID in instance.get('members')
          levelCompletes = _.map campaign.getNonLadderLevels().models, (level) ->
>>>>>>> refs/remotes/codecombat/master
            return true if level.isLadder()
            #TODO: Hella slow! Do the mapping first!
            session = _.find classroom.sessions.models, (session) ->
              session.get('creator') is userID and session.get('level').original is level.get('original')
            # sessionMap[userID][level].completed()
            session?.completed()
<<<<<<< HEAD
          if allComplete
            instance.numCompleted += 1
=======
          if _.every levelCompletes
            instance.numCompleted += 1
          if _.any levelCompletes
            instance.numStarted += 1
>>>>>>> refs/remotes/codecombat/master

  calculateEarliestIncomplete: (classroom, courses, campaigns, courseInstances, students) ->
    # Loop through all the combinations of things, return the first one that somebody hasn't finished
    for course, courseIndex in courses.models
<<<<<<< HEAD
      instance = courseInstances.getByCourseAndClassroom(course, classroom)
      continue if not instance
      campaign = campaigns.get(course.get('campaignID'))
      for level, levelIndex in campaign.getNonladderLevels().models
        userIDs = []
        for userID in instance.get('members')
=======
      instance = courseInstances.findWhere({ courseID: course.id, classroomID: classroom.id })
      continue if not instance
      campaign = campaigns.get(course.get('campaignID'))
      for level, levelIndex in campaign.getNonLadderLevels().models
        userIDs = []
        for user in students.models
          userID = user.id
>>>>>>> refs/remotes/codecombat/master
          session = _.find classroom.sessions.models, (session) ->
            session.get('creator') is userID and session.get('level').original is level.get('original')
          if not session?.completed()
            userIDs.push userID
        if userIDs.length > 0
          users = _.map userIDs, (id) ->
            students.get(id)
          return {
            courseNumber: courseIndex + 1
            levelNumber: levelIndex + 1
            levelName: level.get('name')
            users: users
          }
<<<<<<< HEAD
    return {}
=======
    null
>>>>>>> refs/remotes/codecombat/master

  calculateLatestComplete: (classroom, courses, campaigns, courseInstances, students) ->
    # Loop through all the combinations of things in reverse order, return the level that anyone's finished
    courseModels = courses.models.slice()
    for course, courseIndex in courseModels.reverse() #
      courseIndex = courses.models.length - courseIndex - 1 #compensate for reverse
<<<<<<< HEAD
      instance = courseInstances.getByCourseAndClassroom(course, classroom)
      continue if not instance
      campaign = campaigns.get(course.get('campaignID'))
      levelModels = campaign.getNonladderLevels().models.slice()
      for level, levelIndex in levelModels.reverse() #
        levelIndex = levelModels.length - levelIndex - 1 #compensate for reverse
        userIDs = []
        for userID in instance.get('members')
=======
      instance = courseInstances.findWhere({ courseID: course.id, classroomID: classroom.id })
      continue if not instance
      campaign = campaigns.get(course.get('campaignID'))
      levelModels = campaign.getNonLadderLevels().models.slice()
      for level, levelIndex in levelModels.reverse() #
        levelIndex = levelModels.length - levelIndex - 1 #compensate for reverse
        userIDs = []
        for user in students.models
          userID = user.id
>>>>>>> refs/remotes/codecombat/master
          session = _.find classroom.sessions.models, (session) ->
            session.get('creator') is userID and session.get('level').original is level.get('original')
          if session?.completed() #
            userIDs.push userID
        if userIDs.length > 0
          users = _.map userIDs, (id) ->
            students.get(id)
          return {
            courseNumber: courseIndex + 1
            levelNumber: levelIndex + 1
            levelName: level.get('name')
            users: users
          }
<<<<<<< HEAD
    return {}
    
=======
    null
    
  calculateConceptsCovered: (classrooms, courses, campaigns, courseInstances, students) ->
    # Loop through all level/user combination and record
    #   whether they've started, and completed, each concept
    conceptData = {}
    for classroom in classrooms.models
      conceptData[classroom.id] = {}
      
      for course, courseIndex in courses.models
        campaign = campaigns.get(course.get('campaignID'))
        
        for level in campaign.getNonLadderLevels().models
          levelID = level.get('original')
          
          for concept in level.get('concepts')
            unless conceptData[classroom.id][concept]
              conceptData[classroom.id][concept] = { completed: true, started: false }

          for concept in level.get('concepts')
            for userID in classroom.get('members')
              session = _.find classroom.sessions.models, (session) ->
                session.get('creator') is userID and session.get('level').original is levelID
              
              if not session # haven't gotten to this level yet, but might have completed others before
                for concept in level.get('concepts')
                  conceptData[classroom.id][concept].completed = false
              if session # have gotten to the level and at least started it
                for concept in level.get('concepts')
                  conceptData[classroom.id][concept].started = true
              if not session?.completed() # level started but not completed
                for concept in level.get('concepts')
                  conceptData[classroom.id][concept].completed = false
    conceptData
      
>>>>>>> refs/remotes/codecombat/master
  calculateAllProgress: (classrooms, courses, campaigns, courseInstances, students) ->
    # Loop through all combinations and record:
    #   Completeness for each student/course
    #   Completeness for each student/level
    #   Completeness for each class/course (across all students)
    #   Completeness for each class/level (across all students)
    
    # class -> course
    #   class -> course -> student
    #   class -> course -> level
    #     class -> course -> level -> student
    
    progressData = {}
    for classroom in classrooms.models
      progressData[classroom.id] = {}

      for course, courseIndex in courses.models
<<<<<<< HEAD
        instance = courseInstances.getByCourseAndClassroom(course, classroom)
=======
        instance = courseInstances.findWhere({ courseID: course.id, classroomID: classroom.id })
>>>>>>> refs/remotes/codecombat/master
        if not instance
          progressData[classroom.id][course.id] = { completed: false, started: false }
          continue
        progressData[classroom.id][course.id] = { completed: true, started: false } # to be updated
        
<<<<<<< HEAD
        # For debugging
        progressData[classroom.id][course.id]

        campaign = campaigns.get(course.get('campaignID'))
        for level in campaign.getNonladderLevels().models
          levelID = level.get('original')
          progressData[classroom.id][course.id][levelID] = { completed: true, started: false }
          
          for userID in classroom.get('members')
            progressData[classroom.id][course.id][userID] ?= { completed: true, started: false } # Only set it the first time through a user
            progressData[classroom.id][course.id][levelID][userID] = { completed: true, started: false } # These don't matter, will always be set
=======
        campaign = campaigns.get(course.get('campaignID'))
        for level in campaign.getNonLadderLevels().models
          levelID = level.get('original')
          progressData[classroom.id][course.id][levelID] = { completed: students.size() > 0, started: false }
          
          for user in students.models
            userID = user.id
            courseProgress = progressData[classroom.id][course.id]
            courseProgress[userID] ?= { completed: true, started: false } # Only set it the first time through a user
            courseProgress[levelID][userID] = { completed: true, started: false } # These don't matter, will always be set
>>>>>>> refs/remotes/codecombat/master
            session = _.find classroom.sessions.models, (session) ->
              session.get('creator') is userID and session.get('level').original is levelID

            if not session # haven't gotten to this level yet, but might have completed others before
<<<<<<< HEAD
              progressData[classroom.id][course.id].started ||= false #no-op
              progressData[classroom.id][course.id].completed = false
              progressData[classroom.id][course.id][userID].started ||= false #no-op
              progressData[classroom.id][course.id][userID].completed = false
              progressData[classroom.id][course.id][levelID].started ||= false #no-op
              progressData[classroom.id][course.id][levelID].completed = false
              progressData[classroom.id][course.id][levelID][userID].started = false
              progressData[classroom.id][course.id][levelID][userID].completed = false
            if session # have gotten to the level and at least started it
              progressData[classroom.id][course.id].started = true
              progressData[classroom.id][course.id][userID].started = true
              progressData[classroom.id][course.id][levelID].started = true
              progressData[classroom.id][course.id][levelID][userID].started = true
            if session?.completed() # have finished this level
              progressData[classroom.id][course.id].completed &&= true #no-op
              progressData[classroom.id][course.id][userID].completed = true
              progressData[classroom.id][course.id][levelID].completed &&= true #no-op
              progressData[classroom.id][course.id][levelID][userID].completed = true
            else # level started but not completed
              progressData[classroom.id][course.id].completed = false
              progressData[classroom.id][course.id][userID].completed = false
              progressData[classroom.id][course.id][levelID].completed = false
              progressData[classroom.id][course.id][levelID][userID].completed = false
=======
              courseProgress.started ||= false #no-op
              courseProgress.completed = false
              courseProgress[userID].started ||= false #no-op
              courseProgress[userID].completed = false
              courseProgress[levelID].started ||= false #no-op
              courseProgress[levelID].completed = false
              courseProgress[levelID][userID].started = false
              courseProgress[levelID][userID].completed = false
            if session # have gotten to the level and at least started it
              courseProgress.started = true
              courseProgress[userID].started = true
              courseProgress[levelID].started = true
              courseProgress[levelID][userID].started = true
            if session?.completed() # have finished this level
              courseProgress.completed &&= true #no-op
              courseProgress[userID].completed = true
              courseProgress[levelID].completed &&= true #no-op
              courseProgress[levelID][userID].completed = true
            else # level started but not completed
              courseProgress.completed = false
              courseProgress[userID].completed = false
              courseProgress[levelID].completed = false
              courseProgress[levelID][userID].completed = false
>>>>>>> refs/remotes/codecombat/master

    _.assign(progressData, progressMixin)
    return progressData
  
progressMixin =
  get: (options={}) ->
    { classroom, course, level, user } = options
    throw new Error "You must provide a classroom" unless classroom
    throw new Error "You must provide a course" unless course
    defaultValue = { completed: false, started: false }
    if options.level
      levelID = level.get('original')
      if options.user
<<<<<<< HEAD
        return @[classroom.id][course.id][levelID][user.id] or defaultValue
      else
        return @[classroom.id][course.id][levelID] or defaultValue
    else
      if options.user
        return @[classroom.id][course.id][user.id] or defaultValue
      else
        return @[classroom.id][course.id] or defaultValue
=======
        return @[classroom.id]?[course.id]?[levelID]?[user.id] or defaultValue
      else
        return @[classroom.id]?[course.id]?[levelID] or defaultValue
    else
      if options.user
        return @[classroom.id]?[course.id]?[user.id] or defaultValue
      else
        return @[classroom.id]?[course.id] or defaultValue
>>>>>>> refs/remotes/codecombat/master
