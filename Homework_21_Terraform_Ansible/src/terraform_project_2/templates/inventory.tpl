[app]
%{ for ip in public_ips ~}
${ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/home/dmytro/terraform_project_2/Dmytro.pem
%{ endfor ~}
