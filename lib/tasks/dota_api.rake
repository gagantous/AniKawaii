desc "Fetch dota2 wallpapers"
task :dota2 => :environment do
   mechanize = Mechanize.new
    #Pop in your URL to work the magic
    url = "http://dota2walls.com/"
    page = mechanize.get(url) 

    def paginate_link(link)
      #loop function pagination GET

      mechanize = Mechanize.new
      page = mechanize.get(link)
      loop do
        find_links = page.link_with(text: " Previous Wallpapers")
        if find_links 
          page = find_links.click
          url = page.uri.to_s
          p "The page URL is #{url}"
          scrape_category_img(page.uri)
        else 
          p "Can't find anymore pagination links, moving to next section"
          break
        end
      end
    end

    def scrape_hd_img(link,thumbnail_url)
      sleep(1)
      mechanize = Mechanize.new
      page = mechanize.get(link)
      url = link
      img_link = url.to_s
      mechanize = Mechanize.new
      page = mechanize.get(img_link)
      img_src = page.search(".download-button > p > a").attr("href").text.strip
      p "HD #{img_src} - Thumbnail #{thumbnail_url}"
      item = ApiItem.find_or_create_by(image: img_src,api_type: "dota2_wallpaper",image_thumbnail: thumbnail_url)
      if item.save
        p "HD Img#{img_src} ----- Thumbnail #{thumbnail_url}"
      else
        p "Failed to save the api_item!"
      end
    end

    def scrape_img(url)
      img_link = url.to_s
      mechanize = Mechanize.new
      page = mechanize.get(img_link)
      p "Scraping category img #{img_link}"
      wallpapers = page.search('article')
      wallpaper_images = []
      wallpapers.each do |wallpaper|
        img = wallpaper.search('div > a > img')
        img_attr = img.attr('data-lazy-src')
        if img_attr # if lazy attr exist, use else use src attr
          img_src = img.attr('data-lazy-src').text.strip
        else
          p "Adjusting img src attribute for #{img_link} because bad attribute"
          img_src = img.attr('src').text.strip
        end
        hd_image_link = wallpaper.search("div > a").attr("href").text.strip
        scrape_hd_img(hd_image_link,img_src)
      end
    end

    def scrape_category_img(url)
      img_link = url.to_s
      mechanize = Mechanize.new
      page = mechanize.get(img_link)
      p "Scraping category img #{img_link}"
      wallpapers = page.search('article')
      wallpaper_images = []
      wallpapers.each do |wallpaper|
        img = wallpaper.search('div > a > img')
        hd_image_link = wallpaper.search("div > a").attr("href").text.strip
        img_attr = img.attr('data-lazy-src')
        if img_attr # if lazy attr exist, use else use src attr
          img_src = img.attr('data-lazy-src').text.strip
        else
          p "Adjusting img src attribute for #{img_link} because bad attribute"
          img_src = img.attr('src').text.strip
        end
        scrape_hd_img(hd_image_link,img_src)
      end
      paginate_link(url)
    end

   # get icons and their links
     icons = page.search('#main > .categories > a')
      p 'Loading Dota2 Icons......'
      icon_category_links = []
      icons.each do |char|
        char_img_src = char.search('img').attr('src').text
        char_link = char.attr('href')
        item = ApiItem.find_or_create_by(image: char_img_src,api_type: "dota2_icon",link: char_link)
        icon_category_links << char_link
        if item.save
          p "Api Icon Item generated #{char_img_src}"
        else
          p "Failed to save the api_item!"
        end
     end
   # scrape icon categories
    icon_category_links.each do |link|
      scrape_category_img(link)
    end
    p 'Icon Scraping Complete'
    sleep(20)
    

    #Scrape wallpapers
    wallpapers = page.search('article')
    wallpaper_images = []
    wallpapers.each do |wallpaper|
      img = wallpaper.search('div > a > img') 
      img_attr = img.attr('data-lazy-src')
      if img_attr # if lazy attr exist, use else use src attr
        img_src = img.attr('data-lazy-src').text.strip
      else
        p "Adjusting img src attribute for #{img_src} because bad attribute"
        img_src = img.attr('src').text.strip
      end
      hd_image_link = wallpaper.search("div > a").attr("href").text.strip
      scrape_hd_img(hd_image_link,img_src)
    end
    #Loop through all pagination links for wallpaper
    loop do
        find_links = page.link_with(text: " Previous Wallpapers")
        if find_links 
          page = find_links.click
          url = page.uri.to_s
          p "The page URL is #{url}"
          scrape_img(url)
        else 
          p "Finished crawling website for wallpapers"
          break
        end
      end

end

