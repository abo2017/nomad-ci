$script = <<SCRIPT

# Install Java and dnsmasq
apt-get install -y unzip daemon dnsmasq

sleep 2

echo Fetching Nomad...
cd /tmp/
rm -f nomad*
wget --quiet https://releases.hashicorp.com/nomad/0.3.2/nomad_0.3.2_linux_amd64.zip -O nomad.zip
echo Installing Nomad...
unzip nomad.zip
sudo chmod 755 nomad
sudo mv nomad /usr/bin/nomad

# Start Nomad as a daemon in developer mode. This runs Nomad in server and client mode at the same time.
echo Starting Nomad..
daemon --name=nomad --output=/vagrant/nomad.log --command="/usr/bin/nomad agent -dev -config /vagrant/nomad/config"

echo Fetching Consul...
cd /tmp/
rm -f consul*
wget --quiet https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip -O consul.zip
echo Installing Consul...
unzip consul.zip
sudo chmod +x consul
sudo mv consul /vagrant/consul/bin/consul

# Make sure the Consul binary and config are in the exec driver's chroot
cp -fr /vagrant/consul /usr/bin

# Give Nomad some time to start
sleep 5

# Schedule Consul on the node
echo Starting Consul..
nomad run /vagrant/nomad/jobs/consul.nomad

# Copy service configuration files
sudo cp /vagrant/config/docker_daemon_config /etc/default/docker
sudo cp /vagrant/config/dnsmasq.conf /etc/dnsmasq.conf
sudo cp /vagrant/config/resolv.conf.dnsmasq /etc/resolv.conf.dnsmasq

# Restart services to activate new configuration
sudo service docker restart
sudo service dnsmasq restart

SCRIPT

Vagrant.configure(2) do |config|
 
  config.vm.define "ci" do |ci|
    ci.vm.box = "ubuntu/trusty64"
    ci.vm.network "private_network", ip: "192.168.10.10"
	ci.vm.network "forwarded_port", guest: 8080, host: 10080,
      auto_correct: true
	ci.vm.network "forwarded_port", guest: 50000, host: 50000,
      auto_correct: true
	ci.vm.network "forwarded_port", guest: 8500, host: 8500,
      auto_correct: true
    ci.vm.provider "virtualbox" do |vb|
      vb.memory = 5120
      vb.cpus = 2
    end
    ci.vm.synced_folder ".", "/vagrant"
    ci.vm.provision "docker"
    ci.vm.provision "shell", inline: $script
  end
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http = "http://192.168.22.1:3129"
    config.proxy.https = "http://192.168.22.1:3129"
    config.proxy.no_proxy = "localhost,127.0.0.1,192.168.10.10,registry.service.consul" 
  end 
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
    config.vbguest.no_install = true
    config.vbguest.no_remote = true
  end
end
