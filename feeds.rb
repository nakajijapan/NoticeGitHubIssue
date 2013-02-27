# coding: utf-8

require 'open-uri'
require 'simple-rss'
require 'active_support/all'


#---------------------------------------
# a painful modification
#---------------------------------------
class SimpleRSS_CSTM < SimpleRSS
  def unescape(content)
    if content =~ /([^-_.!~*'()a-zA-Z\d;\/?:@&=+$,\[\]]%)/u then
      CGI.unescape(content).gsub(/(<!\[CDATA\[|\]\]>)/,'').strip
    else
      content.gsub(/(<!\[CDATA\[|\]\]>)/,'').strip
    end
  end
end

#---------------------------------------
# main
#---------------------------------------
load File::expand_path('', File::dirname(__FILE__)) + '/config.rb'

if ARGV[0].nil?
  p "please organization name"
  exit
end
organization = ARGV[0]

feed_url = "https://github.com/organizations/#{organization}/#{$USERNAME}.private.atom?token=#{$USER_TOKEN}"

rss = SimpleRSS_CSTM.parse open(feed_url)

rss.items.each do |item|
  next if item.title =~ /pushed/

  # init
  now = Time.now
  updated = item.updated.getlocal
  regex_content = /blockquote&gt;(.+)&lt;\/blockquote/

  #p "[#{updated}] #{item.title}"
  if item.updated > now - 5.minutes
    content = ''
    contents = item.content.gsub(/\n/, '').scan(regex_content)
    unless contents.empty?
      content = contents.pop.pop.strip
      content = content.gsub(/&lt;\/?p&gt;/, '') 
      content = content.gsub(/&lt;\/?code&gt;/, '') 
    end

    # via ikachan
    system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"GitHub  #{item.title} \" #{$IRC_URL}")
    system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"GitHub  #{content}  \" #{$IRC_URL}") if content.present?
    system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"GitHub  #{item.link}  \" #{$IRC_URL}")
  end
end

