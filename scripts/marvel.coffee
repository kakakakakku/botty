# Description:
#   Get Marvel infomation by "Marvel Comics API"
#
# Commands:
#   hubot /marvel characters :name - Get Marvel character by name
api = require('marvel-api');

module.exports = (robot) ->

  robot.respond /marvel characters (.+)$/i, (msg) ->
    characterName = msg.match[1]

    unless isSetPublicKey msg
      return

    unless isSetPrivateKey msg
      return

    marvel = api.createClient(
      publicKey: process.env.HUBOT_MARVEL_API_PUBLIC_KEY,
      privateKey: process.env.HUBOT_MARVEL_API_PRIVATE_KEY
    )

    marvel.characters.findByName characterName, (err, res) ->
      if err
        console.log err
      image_path = res.data[0].thumbnail.path
      image_extension = res.data[0].thumbnail.extension
      image_size = 'standard_amazing'
      msg.send image_path + '/' + image_size + '.' + image_extension

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
