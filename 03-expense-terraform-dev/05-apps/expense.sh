#!bin/bash
dnf install ansible -y
cd /tmp
git clone https://github.com/Medasanicharan/Expense-ansible-roles.git
cd Expense-ansible-roles
ansible-playbook main.yaml -e component=backend -e login_paassword=ExpenseApp1
ansible-playbook main.yaml -e component=frontend
