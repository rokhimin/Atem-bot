task :default => [:welcome]

namespace :run do
  desc "running driven test"
  task :spec do
    sh 'rspec spec/index_spec.rb'
  end
  desc "running discord bot"
  task :discord do
    sh 'ruby bin/DISCORD'
  end
  desc "running telegram bot"
  task :telegram do
    sh 'ruby bin/TELEGRAM'
  end
end

task :welcome do
  puts "hi follow my twitter https://twitter.com/rokhiminwahid"
end


