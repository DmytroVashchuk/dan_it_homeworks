Vagrant.configure("2") do |config|
  # Налаштування DB_VM
  config.vm.define "db_vm" do |db_vm|
    db_vm.vm.box = "ubuntu/bionic64"
    db_vm.vm.network "private_network", ip: "192.168.56.10"
    db_vm.vm.provision "shell", path: "scripts/db_setup.sh"
    db_vm.vm.hostname = "db_vm"
  end

  # Налаштування APP_VM
  config.vm.define "app_vm" do |app_vm|
    app_vm.vm.box = "ubuntu/bionic64"
    app_vm.vm.network "private_network", ip: "192.168.56.11"
    app_vm.vm.provision "shell", path: "scripts/app_setup.sh"
    app_vm.vm.hostname = "app_vm"
    app_vm.vm.network "forwarded_port", guest: 8080, host: 8080
  end
end

