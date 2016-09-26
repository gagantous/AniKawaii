desc "Upload local images"
task :local_images => :environment do
  @images = Dir.glob("#{Rails.root}/db/images/*.{jpg,jpeg,png}")
  @images.each do |i|
    location = Pathname.new(i).open
    d = ApiDota.new
    d.img = location
    d.api_type = "dota2_popular"
    d.save
    p "Successfully saved #{i}"
  end
  "Uploading local images complete!"
end

