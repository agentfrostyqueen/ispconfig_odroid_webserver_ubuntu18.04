#---------------------------------------------------------------------
# Function: InstallFail2ban
#    Install and configure fail2ban
#---------------------------------------------------------------------
InstallFail2ban() {
  echo -n "Installing Intrusion protection (Fail2Ban)... "
  apt_install fail2ban
  echo -e "[${green}DONE${NC}]\n"
  echo -n "Installing Firewall (UFW)... "
  apt_install ufw

cat >> /etc/fail2ban/jail.local <<EOF
[pureftpd]
enabled = true
port = ftp
filter = pureftpd
logpath = /var/log/syslog
maxretry = 3
EOF

cat > /etc/fail2ban/filter.d/pureftpd.conf <<EOF
[Definition]
failregex = .*pure-ftpd: \(.*@<HOST>\) \[WARNING\] Authentication failed for user.*
ignoreregex =
EOF

  echo -e "[${green}DONE${NC}]\n"
  echo -n "Restarting Fail2Ban... "
  service fail2ban restart
  echo -e "[${green}DONE${NC}]\n"
}

