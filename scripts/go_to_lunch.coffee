# Description:
#   Go to lunch!
#
# Commands:
#   hubot go for to list - List members
#   hubot go for to join :name - Join lunch
#   hubot go for to clear - Clear lunch event
#
# Author:
#   kakakakakku <https://github.com/kakakakakku>

module.exports = (robot) ->
  key = 'lunch'

  robot.respond /go to lunch list$/, (msg) ->
    members = getMembers()
    if members.length is 0
      msg.send members.toString()
      return
    msg.send 'No member exist.'

  robot.respond /go to lunch join (\S+)$/, (msg) ->
    member = msg.match[1]
    members = getMembers()
    if member in members
      msg.send 'You are already joined.'
      return

    if members.length is 0
      tmpMembers = members
    else
      tmpMembers = []

    tmpMembers.push member

    robot.brain.set key, tmpMembers
    msg.send tmpMembers.toString()

  robot.respond /go to lunch clear$/, (msg) ->
    robot.brain.set key, []
    msg.send 'Lunch is closed.'

  getMembers = ->
    robot.brain.get(key) ? []
