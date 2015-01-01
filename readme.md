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

Run the rake task to provision your Mybema droplet:

    rake
    
This should take around 30 minutes to complete. Within the first 5 minutes you may be asked to trust the VPS you're deploying to. You should type `yes` and hit the return (enter) key. Then at around the 10 minute mark it will ask you for your password. Enter `mypass` and hit return.

Once that's all done, because of an existing [small bug with our ansible tasks](https://github.com/mybema/mybema-config/issues/4), you'll need to SSH to your newly created VPS and restart nginx using (the password is the same as above):

    sudo service nginx restart
    
Once that's done, you can point your browser at the IP address and you're good to go!
    
Running into problems
=====================
Sometimes Digitalocean takes a little longer than expected to create a new droplet. If that happen you'll see a task will fail very early during the above rake task. You'll either want to destroy that droplet and try again, or you can retry on the same VPS. To retry, you should run the 2 ansible playbook commands found in the [alternative installation](https://github.com/mybema/mybema-config/wiki/Alternative-installation#if-you-dont-use-digitalocean) page. This will prevent you from spinning up another droplet on DO.

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
