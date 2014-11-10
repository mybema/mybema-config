What is this?
=============
This repository contains [Ansible](http://www.ansible.com) playbooks and some ruby scripts that allow you to quickly install a [Mybema](http://www.github.com/pawel2105/mybema) instance on a [DigitalOcean](http://www.digitalocean.com) VPS.

Caveat: WIP
===========
This project is a work-in-progress. Things may break. If you see anything that can be improved, please submit a pull request.

Prerequisites
=============
The only things you need before getting started are the following:

* A DigitalOcean account
* Python and a way to install Ansible

Installation steps
==================
Run the following steps in order to set up your instance. First clone this repo:

    git clone git@github.com:pawel2105/mybema-config.git

Install the necessary gems:

    bundle install

Create a file to store your SSH key and add it to the file once it's created:

    cp playbooks/public_keys/mybema-user.example playbooks/public_keys/mybema-user

Add your DigitalOcean API token:

    cp playbooks/digital_ocean_token.yml.example playbooks/digital_ocean_token.yml

Create a new VPS and update the root password:

    ruby 1_create_vps.rb

Add your IP to a new hosts file:

    cp playbooks/hosts.example playbooks/hosts

Copy your SSH key onto the VPS:

    ruby 2_copy_ssh_keys.rb

Run the playbook to bootstrap the VPS:

    ruby 3_bootstrap_vps.rb
    # password is mypass

Run the rest of the setup using the setup playbook:

    ruby 4_setup_vps.rb

Destroying the droplet
======================
If you want to completely destroy the droplet, run the following:

    ruby 5_destroy_vps.rb

Note that this is permanent and you will not be able to get your data back.