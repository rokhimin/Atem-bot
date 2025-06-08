task default: [:welcome]

task :welcome do
  puts "List Command Atem Bot\n===============================\nrake run:test => Unit Test \nrake run:dc => Run bot Discord \nrake run:tele => Run bot Telegram \nrake run:wa => Run bot Whatsapp \n===============================\nfollow my Github https://github.com/whdzera"
end

namespace :run do
  task :test do
    sh 'rspec spec/index_spec.rb'
  end
  task :dc do
    sh 'ruby bin/DISCORD'
  end
  task :tele do
    sh 'ruby bin/TELEGRAM'
  end
  task :wa do
    sh 'ruby bin/WHATSAPP'
  end
end
