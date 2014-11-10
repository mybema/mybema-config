require 'droplet_kit'
require 'yaml'

access_token = YAML.load(File.open("./playbooks/digital_ocean_token.yml"))
client  = DropletKit::Client.new(access_token: access_token['digital_ocean'])

# The block below lists your DO droplets. Copy the ID of mybema
# Paste it into line 14 as an integer, uncomment the line and re-run this script.

client.droplets.all.each do |droplet|
  puts "#{droplet.name} - #{droplet.id}"
end

# client.droplets.delete(id: 00000000)