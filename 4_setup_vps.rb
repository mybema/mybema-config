puts "\nSetting up the VPS"
exec 'ansible-playbook playbooks/setup.yml -i playbooks/hosts -K'