desc "Upload local images"
task :update_api_urls => :environment do
  @dota = ApiDota.where.not(api_type: "dota2_popular")
  @dota.each do |i|
    i.remote_img_url = i.image
    sleep(2.5)
    i.save
    p "Successfully saved #{i}"
  end
  "Uploading local images complete!"
end

