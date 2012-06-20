# -*- coding: utf-8 -*-
require 'Octokit'
load File::expand_path('', File::dirname(__FILE__)) + '/config.rb'

c = Octokit::Client.new(:login => $USERNAME, :password => $PASSWORD)

if ARGV[0].nil?
 p "please repos"
 exit
end

p "repo = #{ARGV[0]}"
repo = ARGV[0]
id_file =  File::expand_path('cache', File::dirname(__FILE__)) + '/issues_' + repo.gsub(/\//, '_') + '.id'
p "id file = #{id_file}"


issues = c.issues(repo)

current_id = nil
if File.exists?(id_file)
  current_id = File.open(id_file, 'r'){|f| f.readlines[0]}
end


if current_id.nil?
  current_id = 0
else
  current_id = current_id.strip.to_i
end

max_id = current_id
issues.each do |i|
  if i.id > current_id
    max_id = i.id if i.id > max_id

    label = []
    i.labels.each {|l| label.push l.name }

    # via ikachan
    system("curl -F channel=\##{$IRC_CHANNEL} -F message=\"GitHub  #{i.title} :  #{i.user.login} created >>  #{i.html_url} \" #{$IRC_URL}")
  end
end

File.open(id_file, 'w+'){|f| f.write max_id}












