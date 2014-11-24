#!/usr/bin/env rake

require 'droplet_kit'
require 'securerandom'
require 'yaml'

task :default do
  Rake::Task["provisioning:create_vps"].invoke
  Rake::Task["provisioning:copy_ssh_keys"].invoke
  Rake::Task["provisioning:bootstrap_vps"].invoke
  Rake::Task["provisioning:setup_vps"].invoke
end

namespace :provisioning do
  task :add_secret_key do
    secret = SecureRandom.hex(64)
    system "sed -i '' 's/XXX/#{secret}/' ./playbooks/roles/deploy/templates/secrets.yml.j2"
  end

  task :create_vps do
    puts "Creating a new DigitalOcean droplet"
    droplets = []
    access_token = YAML.load(File.open("./playbooks/digital_ocean_token.yml"))
    client  = DropletKit::Client.new(access_token: access_token['digital_ocean'])
    droplet = DropletKit::Droplet.new(name: 'mybema',
                                      region: 'nyc2',
                                      image: 'ubuntu-14-04-x64',
                                      size: '512mb')
    client.droplets.create(droplet)

    client.droplets.all.each { |drop| droplets << drop.id }
    droplet_networks = client.droplets.find(id: droplets.last).networks.first
    $ip_address      = droplet_networks.first.ip_address

    system "cp ./playbooks/hosts.example ./playbooks/hosts"
    system "sed -i '' 's/^\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}$/#{$ip_address}/' ./playbooks/hosts"
  end

  task :copy_ssh_keys do
    puts 'Waiting for the droplet to boot up'
    (1..150).each { |x| print '.'; sleep(1) }
    puts "\nCopying your SSH key to your server located at #{$ip_address}"
    system "cat ./playbooks/public_keys/mybema-user | ssh root@#{$ip_address} 'cat >> ~/.ssh/authorized_keys'"
  end

  task :bootstrap_vps do
    puts "\nSetting up the VPS"
    system 'ansible-playbook playbooks/bootstrap.yml -i playbooks/hosts'
  end

  task :setup_vps do
    puts "\nSetting up the VPS"
    system 'ansible-playbook playbooks/setup.yml -i playbooks/hosts -K'
  end

  task :restart_server do
    system 'ansible-playbook playbooks/restart.yml -i playbooks/hosts'
  end
end

task :destroy_vps do
  puts "Destroying your droplet"
  droplets = []
  access_token = YAML.load(File.open("./playbooks/digital_ocean_token.yml"))
  client       = DropletKit::Client.new(access_token: access_token['digital_ocean'])

  client.droplets.all.each { |drop| droplets << drop.id if drop.name == 'mybema' }
  if droplets.any?
    client.droplets.delete(id: droplets.first)
    puts "Droplet destroyed"
  end
end