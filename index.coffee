# Description:
#   Uses Google PageSpeed API to check if a site is mobile friendly
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot is <domain> mobile friendly? - Checks if <domain> is up
#
# Author:
#   jmhobbs

module.exports = (robot) ->
  robot.respond /is (?:http\:\/\/)?(.*?) (mobile friendly)(\?)?/i, (msg) ->
    isUp msg, msg.match[1], (domain) ->
      msg.send domain

isUp = (msg, domain, cb) ->
  if !domain.match('^https?://')
    domain = 'http://' + domain
  cb "Requesting Google PageSpeed report for #{domain}"
  msg.http("https://www.googleapis.com/pagespeedonline/v3beta1/mobileReady?url=#{domain}")
    .header('User-Agent', 'Hubot')
    .get() (err, res, body) ->
      response = JSON.parse(body)

      if response.error?
        for error in response.error.errors
          cb "PageSpeed error: #{error.message}"
      if response.ruleGroups?
        if response.ruleGroups.USABILITY?
          if response.ruleGroups.USABILITY.pass
            cb "#{response.id} is mobile friendly (#{response.ruleGroups.USABILITY.score}/100)"
          else
            cb "#{response.id} is not mobile friendly (#{response.ruleGroups.USABILITY.score}/100)"
          cb "- https://www.google.com/webmasters/tools/mobile-friendly/?url=#{response.id}"
      else
        robot.logger.error "mobilefriendly.coffee err:"
        robot.logger.error response
        msg.send "Not sure, #{response.domain} returned an error."
