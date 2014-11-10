require 'droplet_kit'
require 'yaml'

puts "\nPlease paste the IP address of your Digital Ocean server again: \n"

ip_address = gets.sub(/\n/,'')

while ip_address == ""
  puts "Whoops, you accidentally pressed return without pasting in an IP address. Try again:"
  ip_address = gets.sub(/\n/,'')
end

puts "\nCopying your SSH key to the server located at #{ip_address}"
exec "cat /playbooks/public_keys/mybema-user | ssh root@#{ip_address} \"cat >> ~/.ssh/authorized_keys\""
puts "\nDone copying your SSH key"