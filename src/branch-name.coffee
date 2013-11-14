# Description:
#   Vote for a name for a branch
#
# Commands:
#   <number>_<name> - vote for a name
#   hubot brach votes <number> - show votes counts

module.exports = (robot) ->

  robot.hear regex, (msg) ->
    name = msg.match[1]
    number = name.match(/^\d*/)
    @robot.brain.data.votes ||= {}
    @robot.brain.data.votes[number] ||= {}
 
    votes = @robot.brain.data.votes[number][name]
    votes = if votes? then votes + 1 else 1
    @robot.brain.data.votes[number][name] = votes

    msg.send "#{votes} votes for #{name}"

  robot.respond /branch votes (.*)$/i, (msg) ->
    number = msg.match[1]
    
    unless @robot.brain.data.votes?
      msg.send 'No votes!'
      return 
    unless @robot.brain.data.votes[number]?
      msg.send "No votes for #{number}!"
      return

    votesCounts = [] 
    for key in Object.keys(@robot.brain.data.votes[number]) 
      votesCounts.push [key, @robot.brain.data.votes[number][key]]
    votesCounts.sort (a,b) -> a[1] - b[1]

    for count in votesCounts 
      msg.send "#{count[1]} votes for #{count[0]}"

regex = new RegExp /^\s*(\d+_\w[\w_]*)\s*$/





