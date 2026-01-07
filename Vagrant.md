# Vagrant Provisioning Guide

This guide covers provisioning the three virtual machines required for the lab using **Vagrant** and **VirtualBox**.

The setup creates isolated environments for:
- **Nexus** (CentOS Stream 9)
- **SonarQube** (Ubuntu 22.04, with PostgreSQL and Nginx)
- **Jenkins** (Ubuntu 22.04)

All VMs are connected via a private network with static IPs for reliable inter-service communication.

## Prerequisites

- Install [VirtualBox](https://www.virtualbox.org/)
- Install [Vagrant](https://www.vagrantup.com/downloads)
- At least 12–16 GB RAM and 4–6 CPU cores recommended on the host machine
- (Optional) If using AWS EC2 instead of local VirtualBox, adapt the Vagrantfile with an AWS provider (note: may incur charges)

## VM Overview

| VM Name      | Box Image                          | Hostname           | Private IP        | RAM   | CPUs | Provisioning Script |
|--------------|------------------------------------|--------------------|-------------------|-------|------|---------------------|
| nexus        | eurolinux-vagrant/centos-stream-9 | nexus-lab          | 192.168.33.11    | 4 GB  | 2    | nexus.sh            |
| sonarqube    | ubuntu/jammy64                    | sonarqube-lab      | 192.168.33.12    | 4 GB  | 2    | sonarqube.sh        |
| jenkins      | ubuntu/jammy64                    | jenkins-lab        | 192.168.33.13    | 2 GB  | 2    | jenkins.sh          |

All VMs also get a bridged public network adapter for external access.

## Starting the Environment

1. Clone the repository and navigate to the root folder.
2. Ensure the `scripts/` directory contains:
   - `Vagrantfile`
   - `jenkins.sh`
   - `sonarqube.sh`
   - `nexus.sh`
3. Run the following command:

```bash
vagrant up
```

Vagrant will:

- Download the base boxes (if not cached)
- Create and boot the three VMs
- Assign private IPs
- Execute the respective shell provisioning scripts

The process may take 15–30 minutes depending on your internet and host performance.

## Key Snippets from Vagrantfile

Example for the Nexus VM:

```ruby
config.vm.define "nexus" do |nexus|
  nexus.vm.box = "eurolinux-vagrant/centos-stream-9"
  nexus.vm.hostname = "nexus-lab"
  nexus.vm.network "private_network", ip: "192.168.33.11"
  nexus.vm.network "public_network"
  nexus.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end
  nexus.vm.provision "shell", path: "nexus.sh"
end
```

Similar blocks exist for `sonarqube` and `jenkins` with appropriate box, IP, resources, and script.

## What Each Provisioning Script Does

- **jenkins.sh**  
  Updates the system, installs OpenJDK 17, adds the official Jenkins repository, installs and starts Jenkins, opens port 8080.

- **sonarqube.sh**  
  Increases system limits, installs OpenJDK 17 and PostgreSQL, creates the `sonar` database and user, downloads and extracts SonarQube 9.9, configures ownership and properties, sets up a systemd service, installs and configures Nginx as reverse proxy, opens necessary ports, and reboots.

- **nexus.sh**  
  Installs Java 17 (Amazon Corretto), downloads and extracts Nexus 3, creates the `nexus` user, sets up a systemd service, enables and starts Nexus on port 8081.

## Verification After Provisioning

1. Check VM status:

```bash
vagrant status
```

All three should show as `running`.

2. SSH into each VM if needed:

```bash
vagrant ssh jenkins
vagrant ssh sonarqube
vagrant ssh nexus
```

3. Access services in your browser:
   - Jenkins: `http://192.168.33.13:8080`
   - SonarQube: `http://192.168.33.12` (via Nginx on port 80)
   - Nexus: `http://192.168.33.11:8081`

4. Retrieve initial credentials:
   - **Jenkins**: Initial admin password is displayed at the end of `jenkins.sh` execution (or run `sudo cat /var/lib/jenkins/secrets/initialAdminPassword` inside the VM).
   - **SonarQube**: Default login `admin` / `admin` — change immediately.
   - **Nexus**: Default `admin` / `admin123` (confirm via startup logs).

## Cleanup (Optional)

To destroy all VMs:

```bash
vagrant destroy -f
```

To halt:

```bash
vagrant halt
```

Next: Proceed to **[jenkins.md](./jenkins.md)** for Jenkins configuration, tools, plugins, and pipeline setup.
```

**Fixed**: The text after `vagrant up` is now properly inside Markdown (using an unordered list with `-`). No more exiting the code fence prematurely. The entire file is pure, valid GitHub-flavored Markdown and ready to copy.

Let me know when you're ready for `jenkins.md`!
