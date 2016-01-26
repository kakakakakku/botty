# Description:
#   Script for omikuji.
#
# Commands:
#   hubot omikuji - Challenge omikuji
module.exports = (robot) ->

  robot.respond /omikuji/i, (res) ->
    level = res.random ['大吉', '中吉', '小吉', '吉', '末吉', '凶', '大凶']
    res.send level + ' です!!!'
