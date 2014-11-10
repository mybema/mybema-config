require 'droplet_kit'
require 'securerandom'
require 'yaml'

puts "Creating a new Digital Ocean droplet for your Mybema instance"

access_token = YAML.load(File.open("./playbooks/digital_ocean_token.yml"))
client  = DropletKit::Client.new(access_token: access_token['digital_ocean'])
droplet = DropletKit::Droplet.new(name: 'mybema',
                                  region: 'nyc2',
                                  image: 'ubuntu-14-04-x64',
                                  size: '1gb')
client.droplets.create(droplet)

puts "\nCreated Droplet. You should get an email with your IP address and droplet credentials."
puts "Please give it 2 minutes until your droplet spins up."

(1..240).each { |x| print '.'; sleep(0.5) }

puts "\nPlease paste the IP address of the new server: \n"

ip_address = gets.sub(/\n/,'')

while ip_address == ""
  puts "Whoops, you accidentally pressed return without pasting in an IP address. Try again:"
  ip_address = gets.sub(/\n/,'')
end

puts "\nPlease note that Ubuntu forces you to change the root password immediately."
puts "You can change it to this following freshly generated password: (store is somewhere safe)"

puts "\n #{SecureRandom.hex(32)} \n\n"

puts "Connecting to #{ip_address} so that you can change the root password."
puts "Once changed, you can exit and run setup_scripts/setup_vps.rb\n"

exec "ssh root@#{ip_address}"