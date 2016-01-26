# Description:
#   Script for assign member 
#
# Commands:
#   hubot assign - Assign member automatically
module.exports = (robot) ->

  robot.respond /assign/i, (res) ->
    member = res.random ['@kakakakakku', '@botty', '@slackbot']
    res.send member + ' です!!!'
