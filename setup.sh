sudo apt update && apt upgrade -y;

# Add Docker's official GPG key:
sudo apt install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

# install docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# install better shell
sudo apt install -y fish starship
mkdir -p ~/.config/fish
echo 'starship init fish | source' > ~/.config/fish/config.fish

# Add Fish auto-launch to .bashrc
if ! grep -q "exec fish" ~/.bashrc; then
    echo -e "\n# Launch Fish Shell\nif [[ \$- == *i* ]]; then\n    exec fish\nfi" >> ~/.bashrc
fi

# launch fish
fish

# add env variables
sudo apt install -y git lazygit
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install berk-karaal/loadenv.fish
loadenv

# install bork and backup cron script
apt install -y borgbackup
cp backup.sh /usr/local/bin/backup.sh
echo '0 3 * * * /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1' >> /etc/crontab

# install micro and set default
apt install -y micro
set -gx EDITOR=micro

# old bash way way
# for line in (grep -v '^#' .env | grep -v '^$')
#     set -gx (echo $line | cut -d = -f 1) (echo $line | cut -d = -f 2-)
# end

# should exists from copying old volume?
# mkdir -p $BASE_DATA_LOCATION/{database,traefik,nextcloud};
# touch $BASE_DATA_LOCATION/traefik/acme.json;
# chmod 600 $BASE_DATA_LOCATION/traefik/acme.json;

cd /home/personal-vps-builder
docker network create traefik-network
docker network create database-network
docker compose up -d
