# require 'open-uri'
# require 'json'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

desc "Fetch animegif subreddit"
task :fetch_animegifs => :environment do
   CronGif.new
end

