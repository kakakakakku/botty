# Description:
#   Get GitHub trending repositories
#
# Commands:
#   hubot github trending - Get top 5 GitHub trending repositories
cheerio = require 'cheerio'
request = require 'request'

module.exports = (robot) ->

  robot.respond /github trending/, (msg) ->
    query = msg.match[1]

    baseUrl = 'https://github.com'
    request baseUrl + '/trending', (_, res) ->
      $ = cheerio.load res.body

      i = 0
      $('.repo-list-name a').each ->
        a = $(this)
        url = baseUrl + a.attr('href')
        msg.send url
        i++
        if i >= 5
          return false
