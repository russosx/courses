watch("Classes/(.*).php") do |match|
  run_test %{Tests/#{match[1]}Test.php}
end

watch("Tests/.*Test.php") do |match|
  run_test match[0]
end

def run_test(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  result = `phpunit #{file}`
  puts result

  if result.match(/OK/)
    notify "#{file}", "Tests Passed Successfully", "success-icon.png", 2000
  elsif result.match(/FAILURES\!/)
    notify_failed file, result
  end

  clear_console
end

def notify title, msg, img, show_time
  images_dir = '~/store/.autotest'
  system "terminal-notifier -title '#{title}' -message '#{msg}' -appIcon #{images_dir}/#{img}"
end

def notify_failed cmd, result
  failed_examples = result.scan(/failure:\n\n(.*)\n/)
  notify "#{cmd}", failed_examples[0], "attention-icon.png", 6000
end

def clear_console
  puts "\e[H\e[2J"  #clear console
end