require 'multi_json'
require 'googl'

class MessageFormatter
  def self.messages(json)
    msgs = []
    info = MultiJson.load(json)
    branch = info['ref'].split('/').last
    info['commits'].each do |ci|
      url = ci['url']
      ci_title = ci['message'].lines.first.chomp
      msg = "[#{info['repository']['name'].capitalize}(#{branch})] #{ci['author']['name']} | #{ci_title} | #{url}"
      msgs << msg
    end
    return msgs
  end

  def self.short_url(url)
    Googl.shorten(url).short_url
  end
end
