desc "Fetch animegif subreddit"
task :fetch_animegifs => :environment do

  require 'open-uri'
  require 'json'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  url = "https://www.reddit.com/r/animegifs/.json?limit=100"
  #https://www.reddit.com/r/animegifs/.json?limit=100&after=t3_3ipb8o
  subreddit_json = JSON.load open(url)

  subreddit_json["data"]["children"].map do |s| 

     validExtensions = ["jpeg","jpg","gif","gifv","png"]
     title = s["data"]["title"]
     url  = s["data"]["url"]
     permalink = s["data"]["permalink"]
     redditurl = "http://www.reddit.com" + permalink
     upvotes = s["data"]["ups"]
     downvotes = s["data"]["downs"]
     score = s["data"]["score"]

     if url.include? "gfycat"
        puts "I am gfycat"
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
        creation = Animegif.find_or_create_by(name: title,url: url,urlType: "gfycat",
                       webmurl: gfycatWebm,mp4url: gfycatMp4)

        if creation != nil
          creation.update_attribute(:score,score)
          creation.update_attribute(:redditurl,redditurl)
        else
          puts "ERROR!, please check your rake file"
        end
        
     elsif url.include? "imgur"
        next if (!validExtensions.any? {|s| url.include?(s)} && url.include?("imgur") )
       if url.include? "gifv" 
        url.sub!("gifv","gif")
      end
      puts "#{url}"
        urlwebm = url.dup
        urlmp4 = url.dup
        urlposter = url.dup

        urlposter.slice!(".gif?1")
        urlposter.slice!(".gif")
        urlposter << "l.jpg"
        puts "I am Imgur"
        url.slice!("http:")
        url.slice!("https:")
        webm = urlwebm.sub!("gif","webm")
        mp4 = urlmp4.sub!("gif","mp4")

        creation = Animegif.find_or_create_by(name: title,url: url,urlType: urlposter,
                   webmurl: webm,mp4url: mp4)
        if creation != nil
          creation.update_attribute(:score,score)
          creation.update_attribute(:redditurl,redditurl)
        else
          puts "ERROR!, please check your rake file"
        end
     end

    ## puts "#{upvotes} upvotes, #{downvotes} downvotes"
    puts "I ran successfully"
   end
end

