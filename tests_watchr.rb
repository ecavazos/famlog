ENV["WATCHR"] = "1"
system 'clear'

def growl(message)
  growlnotify = `which growlnotify`.chomp
  title = "Watchr Test Results"

  image = image_path(message)

  options = "-w -n Watchr --image '#{image}' -m '#{message}' '#{title}'"
  system %(#{growlnotify} #{options} &)
end

def image_path(message)
  dir = '~/.Watchr_images/'
  name = message.include?('0 failures, 0 errors') ? 'passed.png' : 'failed.png'
  "#{File.expand_path(dir + name)}"
end

def execute(cmd)
  puts(cmd)
  `#{cmd}`
end

def test(file)
  run %Q(ruby -I"lib:test" -rubygems #{file})
end

def test_all
  run 'rake test'
end

def run(command)
  system('clear')
  result = execute command
  growl result.match(/^\d+ tests,.+$/)[0] rescue nil
  puts result
end

def related_test_files(path)
  Dir['test/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ }
end

watch('test/test_helper\.rb') { test_all }
watch('test/.*/.*_test\.rb') { |m| test(m[0]) }

['app/.*/.*\.rb', 'lib/.*/.*\.rb'].each do |p|
  watch(p) { |m| related_test_files(m[0]).map {|tf| test(tf) } }
end

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all tests ---\n\n"
  test_all
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    test_all
  end
end

test_all
