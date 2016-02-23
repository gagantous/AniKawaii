desc "Fetch LOL wallpapers"
task :lol => :environment do

    def scrape_img(url,type,thumb_url)
      img_link = url.to_s
      thumbnail_url = thumb_url.to_s
      api_type = type.to_s
      mechanize = Mechanize.new
      page = mechanize.get(img_link)
      img_src = page.search("#main_wallpaper").attr("src").text.strip
      if type == "fanart"
        img_src.prepend("https:")
      end
      item = ApiLol.find_or_create_by(image: img_src,thumb: thumbnail_url,api_type: api_type)
      if item.save
        p "LOL Wallpaper Item generated #{img_src}"
      else
        p "Failed to save the Wallpaper!"
      end
    end

    def scrape_pagination(url,type)
        img_link = url.to_s
        mechanize = Mechanize.new
        page = mechanize.get(img_link)
        wallpapers = page.search('.container_masonry > .item')
        p "The page URL is #{img_link}"
        wallpaper_images = []
        wallpapers.each do |wallpaper|
          img = wallpaper.search('table > tr > td > .boxgrid > a > img') 
          img_src = img.attr('src').text.strip
          img_link = wallpaper.search('table > tr > td > .boxgrid > a').attr('href').text.strip
          img_src.prepend("https:")
          if type == "main"
            img_link.prepend("https://wall.alphacoders.com/")
          end
          scrape_img(img_link,type,img_src)
       end
    end

   # Scrape "Fanart section"
   def fanart()
    mechanize = Mechanize.new
    url = "https://art.alphacoders.com/by_sub_category/169908"
    page = mechanize.get(url) 
    wallpapers = page.search('.container_masonry > .item')
    wallpaper_images = []
    wallpapers.each do |wallpaper|
      img = wallpaper.search('table > tr > td > .boxgrid > a > img') 
      img_src = img.attr('src').text.strip
      img_link = wallpaper.search('table > tr > td > .boxgrid > a').attr('href').text.strip
      img_src.prepend("https:")
      scrape_img(img_link,"fanart",img_src)
    end
      #p "Thumb " + img_src
      #paginate all wallpapers
      loop do
        find_links = page.link_with(dom_id: "next_page")
          if find_links 
            page = find_links.click
            url = page.uri.to_s
            scrape_pagination(url,"fanart")
          end
        end_paginate_check = page.search("#next_page").attr("href").text.strip
        if end_paginate_check == "#" 
          p "Complete pagination"
          break
        end
      end
        p "Complete scraping for Fanart"

    end
   

   def main()
    mechanize = Mechanize.new
    url = 'https://wall.alphacoders.com/by_sub_category.php?id=169908'
    page = mechanize.get(url) 
    wallpapers = page.search('.container_masonry > .item')
    wallpaper_images = []
    wallpapers.each do |wallpaper|
      img = wallpaper.search('table > tr > td > .boxgrid > a > img') 
      img_src = img.attr('src').text.strip
      img_link = wallpaper.search('table > tr > td > .boxgrid > a').attr('href').text.strip
      img_link.prepend("https://wall.alphacoders.com/")
      scrape_img(img_link,"main",img_src)
        #p "Thumb " + img_src
    end
    #paginate all wallpapers
    loop do
      find_links = page.link_with(dom_id: "next_page")
      end_paginate_check = page.search("#next_page").attr("href").text.strip
      if end_paginate_check == "#" 
        p "Complete pagination"
        break
      end
      if find_links 
        page = find_links.click
        url = page.uri.to_s
        scrape_pagination(url,"main")
      end
    end
    p "Complete scraping for main LOL"
    end
  
   fanart()
   sleep(60)
   main()
   p "Scraping Complete"
end