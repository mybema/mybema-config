#!/usr/bin/env rake

require 'droplet_kit'
require 'securerandom'
require 'yaml'

task :default do
  Rake::Task["provisioning:create_vps"].invoke
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

    ssh_keys = []
    client.ssh_keys.all.each { |key| ssh_keys.push key.id }

    droplet = DropletKit::Droplet.new(name: 'mybema',
                                      region: 'nyc2',
                                      image: 'ubuntu-14-04-x64',
                                      size: '2gb',
                                      ssh_keys: [ssh_keys.first])
    client.droplets.create(droplet)

    client.droplets.all.each { |drop| droplets << drop.id }
    droplet_networks = client.droplets.find(id: droplets.last).networks.first
    $ip_address      = droplet_networks.first.ip_address

    system "cp ./playbooks/hosts.example ./playbooks/hosts"

    if RUBY_PLATFORM.scan(/darwin/).any?
      system "sed -i '' -E 's/([0-9]{1,3}\.){3}[0-9]{1,3}/#{$ip_address}/' ./playbooks/hosts"
    elsif RUBY_PLATFORM.scan(/linux/).any?
      system "sed -i -r 's/([0-9]{1,3}\.){3}[0-9]{1,3}/#{$ip_address}/' ./playbooks/hosts"
    end

    sleep(180)
  end

  task :bootstrap_vps do
    puts "\nSetting up the VPS"
    system 'ansible-playbook playbooks/bootstrap.yml -i playbooks/hosts'
  end

  task :setup_vps do
    puts "\nSetting up the VPS"
    system 'ansible-playbook playbooks/setup.yml -i playbooks/hosts -K'
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