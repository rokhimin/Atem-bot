task :test do
  sh 'rspec spec/index_spec.rb'
end

task :run do
  selected = []

  if ENV['dc'] == 'yes'
    puts 'Running Discord bot'
    Process.spawn('ruby bin/DISCORD')
    selected << 'dc'
  end

  if ENV['tele'] == 'yes'
    puts 'Running Telegram bot'
    Process.spawn('ruby bin/TELEGRAM')
    selected << 'tele'
  end

  if ENV['wa'] == 'yes'
    puts 'Running WhatsApp bot'
    Process.spawn('ruby bin/WHATSAPP')
    selected << 'wa'
  end

  if selected.empty?
    puts "\n📌 No bots selected to run.\n\n"
    puts 'Usage examples:'
    puts '  rake run dc=yes           # Run only Discord bot'
    puts '  rake run wa=yes tele=yes  # Run WhatsApp and Telegram bots'
    puts "  rake run dc=yes wa=yes tele=yes  # Run all bots\n\n"
    puts 'Available options:'
    puts '  dc=yes     → Run Discord bot'
    puts '  wa=yes     → Run WhatsApp bot'
    puts '  tele=yes   → Run Telegram bot'
  else
    puts "\n✅ Started: #{selected.join(', ')} bot(s)."
  end
end

task default: :run
