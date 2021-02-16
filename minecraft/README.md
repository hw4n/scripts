## 1. Create an instance
Instance : ``m5.large``  
Image : ``Ubuntu 20.04``  
And open port ``TCP 25565``

## 2. Install packages
```sh
sudo apt update
sudo apt install openjdk-8-jre-headless screen
```

## 3. Install Minecraft
Before downloading, create a directory

```sh
mkdir minecraft && cd minecraft
```

Also just agree on eula
```sh
echo 'eula=true' > eula.txt
```

### Vanilla server
Get download links from mcversions.net, copy ``Server Jar``'s URL

```sh
wget <download link here>
```

### Forge server
1. Get prefered Forge installer
2. Select ``Install server``
3. Change directory or folder to somewhere else like ``Desktop/minecraft``
4. Put prefered mods in
5. Transfer that directory with sftp

### One more thing
Edit ``server.properties``

Maybe ``spawn-protection=0`` or any other modification needed

---
From this point installation is done but let's automate things up

## 4. Install shell scripts
If you are super rich that has power to pay $0.11/hr for 24/365 you don't have to do this part

You can decrease your aws bill by turning off the instance when not using

Next two scripts make starting and shutting off the server easy

### Installation

Change directory to ``~`` (or ``..`` if you prefer)
```sh
cd ~
wget https://raw.githubusercontent.com/hw4n/scripts/master/minecraft/start.sh
wget https://raw.githubusercontent.com/hw4n/scripts/master/minecraft/stop.sh
```

Make them executable
```sh
chmod +x *.sh
```

Copy start.sh to ./minecraft
```sh
cp start.sh ./minecraft
```

Edit that file with prefered editor but I like vim
```sh
vim minecraft/start.sh
```

Uncomment ``Line 4`` and comment out ``Line 6``

Edit ``.jar`` accordingly to whatever you have

For my case, it is ``forge-1.12.2-14.23.5.2854.jar``

Edit to something look like this:

```sh
#!/bin/bash
  
# minecraft/start.sh only contains command like following
java -server -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -Xmx6144M -Xms4096M -jar forge-1.12.2-14.23.5.2854.jar nogui

# screen -dm -S minecraft bash -c "cd minecraft; ./start.sh"

# also crontab -e and add following
# @reboot /home/ubuntu/start.sh
```

### Add start script to crontab
And lastly let's add start script to crontab so whenever we boot the server it runs minecraft server

Do not sudo or it won't work
```sh
crontab -e
```

And next to last new line:
```
@reboot /home/ubuntu/start.sh
```

To check this boot thing is working:
```sh
sudo reboot
```

SSH again and check if things going on:
```sh
screen -r
```

Detach from screen if you're done checking by pressing ``CTRL + A + D``

## 5. Using aws-control
This uses aws library to turn on/off an instance

Create ``.env``
```
INSTANCE_ID=<AWS instance id>
SSH_HOST=<IP address where to SSH>
SSH_USERNAME=ubuntu
SSH_PRIVATE=<Location of private key for SSH>
```

AWS instance id looks like this: ``i-xxxxxxxxxxxxxxxxx`` if you don't know

### Executing script inside WSL on Windows
This part is probably only for me but the point is that I will execute script located inside the WSL

If target server is different with ``.env`` pass ``<INSTANCE ID>`` and ``<REMOTE IP>`` for arguments for wsl

``start.ps1``
```ps
wsl bash -c "cd ~/projects/scripts/minecraft/aws-control; node index.js start <INSTANCE ID>"
Start-Sleep -s 3
```

``shutdown.ps1``
```ps
wsl bash -c "cd ~/projects/scripts/minecraft/aws-control; node index.js stop <INSTANCE ID> <REMOTE IP>"
Start-Sleep -s 3
```

Execute these powershell scripts to turn on/off server and there we go, cheap and powerful minecraft server
