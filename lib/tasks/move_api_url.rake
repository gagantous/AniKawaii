desc "Upload local images"
task :update_api_urls => :environment do
  @lol = ApiLol.all
  @lol.each do |i|
    i.remote_img_url = i.image
    sleep(5)
    i.save
    p "Successfully saved #{i}"
  end
  "Updating local remote images complete!"
end

