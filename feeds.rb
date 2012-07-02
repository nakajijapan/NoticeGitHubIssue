# coding: utf-8

require 'open-uri'
require 'simple-rss'
require 'active_support/all'

load File::expand_path('', File::dirname(__FILE__)) + '/config.rb'

if ARGV[0].nil?
  p "please organization name"
  exit
end
organization = ARGV[0]

feed_url = "https://github.com/organizations/#{organization}/#{$USERNAME}.private.atom?token=#{$USER_TOKEN}"

rss = SimpleRSS.parse open(feed_url)

rss.items.each do |item|
  next if item.title =~ /pushed/
  now = Time.now

  updated = item.updated.getlocal
  #p "#{updated} > #{5.minutes.ago(now)}"
  #p "[#{updated}] #{item.title}"
  if item.updated > now - 6.minutes
    p "[#{updated}] #{item.title}"

    # via ikachan
    system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"GitHub  #{item.title} \" #{$IRC_URL}")
    system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"GitHub  #{item.link}  \" #{$IRC_URL}")
  end
end

