# Description:
#   Vote for a name for a branch or tag
#
# Commands:
#   <number>_<name> - vote for a name
#   hubot [branch|tag] votes <number> - show votes counts

_ = require 'underscore'

votes_message = (name, votes) ->
  "#{votes.length} vote#{if votes.length==1 then '' else 's'} for #{name} #{if votes.length > 0 then '(' + votes.join(', ') + ')' else ''}"

module.exports = (robot) ->

  robot.hear regex, (msg) ->
    name = msg.match[1]
    number = name.match(/^\d*/)[0]
    user = msg.message.user.name
    @robot.brain.data.votes ||= {}
    @robot.brain.data.votes[number] ||= {}
    @robot.brain.data.votes[number][name] ||= []

    _.each @robot.brain.data.votes[number], (value, key) =>
      @robot.brain.data.votes[number][key] = _.without(value, user)
    @robot.brain.data.votes[number][name].push(user)

    msg.send "#{user} voted for #{name}"
    msg.send votes_message(name, @robot.brain.data.votes[number][name])

  robot.respond /(branch|tag) votes (.*)$/i, (msg) ->
    number = msg.match[2]

    unless @robot.brain.data.votes?
      msg.send 'No votes!'
      return
    unless @robot.brain.data.votes[number]?
      msg.send "No votes for #{number}!"
      return

    _.each @robot.brain.data.votes[number], (v, k) ->
      msg.send votes_message(k, v)

regex = new RegExp /^\s*(\d+_\w[\w_]*)\s*$/





