puts "\nSetting up the VPS"
exec 'ansible-playbook playbooks/bootstrap.yml -i playbooks/hosts'