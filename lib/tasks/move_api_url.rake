desc "Upload local images"
task :local_images => :environment do
  @dota = ApiDota.all
  @dota.each do |i|
    i.full_img.remote_url = i.image
    sleep(5)
    i.save
    p "Successfully saved #{i}"
  end
  "Uploading local images complete!"
end

