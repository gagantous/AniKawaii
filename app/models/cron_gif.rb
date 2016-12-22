class CronGif
	def initialize
		tries ||= 3
    	url = "https://www.reddit.com/r/animegifs/.json?limit=100"
	    begin
	      subreddit_json = JSON.load open(url,'User-Agent' => 'wraithseeker')
	    rescue OpenURI::HTTPError => error
	        puts "#{error}, retrying..."
	        sleep(2.minutes)
	        retry unless (tries -= 1).zero?
	    end
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
		        sleep(1)
	        	urlCajax = parseGfycatURI(url)
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
	          	p url
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
		end
		puts "Success"	
	end

	def parseGfycatURI(url)
		if url.include? "gifv" 
        	url.sub!("gifv","gif")
      	end
		url.slice!("https://gfycat.com/")
	    url.slice!("http://gfycat.com/")
	    urlCajax = "https://gfycat.com/cajax/get/#{url}"
	    return urlCajax
   	end

end