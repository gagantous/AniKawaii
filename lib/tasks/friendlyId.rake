require 'rake'
  desc "Save all gif"
  task :fetch_id=> :environment do
    puts "--- Saving posts ---"
    Animegif.find_each(&:save)
    puts "All posts have been saved.\n"
  end