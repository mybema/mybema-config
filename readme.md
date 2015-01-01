What is this?
=============
This repository contains a collection of [Ansible](http://www.ansible.com) playbooks that allow you to quickly install a [Mybema](http://www.github.com/pawel2105/mybema) instance on a [DigitalOcean](http://www.digitalocean.com) VPS. This project allows you to get up and running very quickly, with minimal configuration.

Prerequisites
=============
The only things you need before getting started are the following:

* OSX or Linux. Windows is not supported
* Python and a way to install Ansible
* `dopy` which can be installed using `sudo pip install dopy`

Other requirements
==================
You should also the the following accounts and credentials. If you don't, please refer to the [alternative installation](https://github.com/mybema/mybema-config/wiki/Alternative-installation) wiki page in this repository for instructions.

* A working DigitalOcean account
* A set of SSH keys uploaded to DigitalOcean. You can do that [here](https://cloud.digitalocean.com/ssh_keys)
* An Amazon S3 account and access tokens

Installation steps
==================
Run the following steps in order to set up your instance. First clone this repo:

    git clone git@github.com:pawel2105/mybema-config.git

Then `cd` into that directory and install the necessary gems:

    bundle install

Create a file to store your SSH key and add it to the file once it's created:

    cp playbooks/public_keys/mybema-user.example playbooks/public_keys/mybema-user

Create a DigitalOcean configuration file and add your API token:

    cp playbooks/digital_ocean_token.yml.example playbooks/digital_ocean_token.yml

Create the secrets file:

    cp playbooks/roles/deploy/templates/secrets.yml.j2.example playbooks/roles/deploy/templates/secrets.yml.j2

Then add your Amazon S3 keys to it. Leave the `secret_key_base` value as `XXX`.

Run the rake task to provision your Mybema droplet (note that your password is `mypass`):

    rake

Destroying the droplet
======================
If you want to completely destroy the droplet, run the following:

    rake destroy_vps

Note that this is permanent and you will not be able to get your data back.

Contributing
============
Contributions are welcome. Please follow the step below:

1. Fork it ( https://github.com/pawel2105/mybema-config/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request