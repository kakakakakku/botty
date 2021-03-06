# Description:
#   Get Marvel infomation by "Marvel Comics API"
#
# Commands:
#   hubot marvel characters :name - Get Marvel character by name (e.g. Iron Man)
#   hubot marvel creators :name - Get Marvel creator by name (e.g. Gurihiru)
api = require('marvel-api')

module.exports = (robot) ->

  robot.respond /marvel characters (.+)$/i, (msg) ->
    characterName = msg.match[1]

    unless isSetPublicKey msg
      return
    unless isSetPrivateKey msg
      return

    client = getClient()
    client.characters.findByName characterName, (err, res) ->
      if err
        console.log err
        return
      if !res.data[0]?
        msg.send 'No character found.'
        return
      sendMarvel(msg, res.data[0])

  robot.respond /marvel creators (.+)$/i, (msg) ->
    creatorName = msg.match[1]

    unless isSetPublicKey msg
      return
    unless isSetPrivateKey msg
      return

    client = getClient()
    client.creators.findByName creatorName, (err, res) ->
      if err
        console.log err
        return
      if !res.data[0]?
        msg.send 'No creator found.'
        return
      sendMarvel(msg, res.data[0])

isSetPublicKey = (msg) ->
  if process.env.HUBOT_MARVEL_API_PUBLIC_KEY?
    return true
  msg.send '"HUBOT_MARVEL_API_PUBLIC_KEY" is not set.'
  return false

isSetPrivateKey = (msg) ->
  if process.env.HUBOT_MARVEL_API_PRIVATE_KEY?
    return true
  msg.send '"HUBOT_MARVEL_API_PRIVATE_KEY" is not set.'
  return false

getClient = ->
  api.createClient(
    publicKey: process.env.HUBOT_MARVEL_API_PUBLIC_KEY,
    privateKey: process.env.HUBOT_MARVEL_API_PRIVATE_KEY
  )

sendMarvel = (msg, obj) ->
  image_path = obj.thumbnail.path
  image_extension = obj.thumbnail.extension
  image_size = 'standard_amazing'

  msg.send obj.name || obj.fullName
  msg.send image_path + '/' + image_size + '.' + image_extension
  msg.send obj.urls[0].url
