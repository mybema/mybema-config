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
* dopy

    sudo pip install dopy

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

Add your Amazon S3 keys to:

    playbooks/roles/deploy/templates/secrets.yml.j2

Run the rake task to provision your Mybema droplet:

    rake
    # your deploy password is mypass

Destroying the droplet
======================
If you want to completely destroy the droplet, run the following:

    rake destroy_vps

Note that this is permanent and you will not be able to get your data back.