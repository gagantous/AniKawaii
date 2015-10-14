desc "Fetch animegif subreddit"
task :fetch_animegifs => :environment do

  require 'open-uri'
  require 'json'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  url = "https://www.reddit.com/r/animegifs/.json?limit=100&after=t3_3ipb8o"
  subreddit_json = JSON.load open(url)

  subreddit_json["data"]["children"].map do |s| 

     validExtensions = ["jpeg","jpg","gif","gifv","png"]
     title = s["data"]["title"]
     url  = s["data"]["url"]
     upvotes = s["data"]["ups"]
     downvotes = s["data"]["downs"]
     score = s["data"]["score"]

     if url.include? "gfycat"
       if url.include? "gifv" 
        url.sub!("gifv","gif")
      end
        url.slice!("https://gfycat.com/")
        url.slice!("http://gfycat.com/")
        urlCajax = "https://gfycat.com/cajax/get/#{url}"

        begin
          gfycatData = JSON.load open(urlCajax)
        rescue OpenURI::HTTPError => error
            puts "Can't open #{urlCajax}"
            next
         end  

       
        gfycatWebm = gfycatData["gfyItem"]["webmUrl"]
        gfycatMp4  = gfycatData["gfyItem"]["mp4Url"]
        Animegif.create(name: title,url: url,score: score,urlType: "gfycat",
                       webmurl: gfycatWebm,mp4url: gfycatMp4)
     else
      #  next if (!validExtensions.any? {|s| url.include?(s)} && url.include?("imgur") )
      #  if url.include? "gifv" 
      #   url.sub!("gifv","gif")
      # end
      # Animegif.create(name: title,url: url,score: score,urlType: "default")
      puts "Not doing anything"
     end

    ## puts "#{upvotes} upvotes, #{downvotes} downvotes"
    puts "I ran successfully"
   end
end

