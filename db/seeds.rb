# import all seeds
CURRENT_PATH = File.dirname(__FILE__)
Dir["#{CURRENT_PATH}/seeds/**/*.rb"].sort.each do |file_path|
  puts "----------------------------------------------"
  require file_path
  puts "\r\n"
end
puts "----------------------------------------------"
