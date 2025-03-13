#!bin/bash
dnf install ansible -y
cd /tmp
git clone https://github.com/Medasanicharan/04-expense-ansible-roles.git
cd 04-expense-ansible-roles
ansible-playbook main.yaml -e component=backend -e PASSWORD=ExpenseApp1
ansible-playbook main.yaml -e component=frontend
# ansible-playbook -i inventory.ini db.yaml 
# ansible-playbook -i inventory.ini backend.yaml
# ansible-playbook -i inventory.ini frontend.yaml