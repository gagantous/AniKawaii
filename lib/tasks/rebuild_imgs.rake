desc "Upload local images"
task :rebuild_dota_imgs => :environment do
  @dota = ApiDota.where.not(api_type: "dota2_popular")
  @dota.each do |i|
  	i.img.recreate_versions! 
    sleep(1)
    i.save
    p "Successfully saved #{i}"
  end
  "Recreate image successful!"
end

