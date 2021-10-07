RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"
red=`tput setaf 1`
white=`tput setaf 7`
clear 
domain=$1
domain1=$2 #for extra domain and proper name 
working_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
results_dir=$working_dir/results
if [ $# -eq 0 ]
then
    for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m──\e[0m" ; done ; echo
    cat << "EOF"
 __   __   __  __     __         __   __     ______     __  __     ______     ______    
/\ \ / /  /\ \/\ \   /\ \       /\ "-.\ \   /\  ___\   /\ \_\ \   /\  ___\   /\  == \   
\ \ \'/   \ \ \_\ \  \ \ \____  \ \ \-.  \  \ \ \____  \ \  __ \  \ \  __\   \ \  __<   
 \ \__|    \ \_____\  \ \_____\  \ \_  "\_\  \ \_____\  \ \_\ \_\  \ \_____\  \ \_\ \_\ 
  \/_/      \/_____/   \/_____/   \/_/ \/_/   \/_____/   \/_/\/_/   \/_____/   \/_/ /_/ 
EOF
    for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m──\e[0m" ; done ; echo 
    echo -e "$RED [!] I need a fucking domain dumbass "
    echo -e "$RED [!] cool.sh <url> <domain> you fucking dumbass"
    echo -e "$RED [!] clear ; ./cools.sh http://testphp.vulnweb.com/listproducts.php?cat=1 testphp.vulnweb.com"
    exit 1
fi
if [ $# -eq 1 ]
then
    for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m──\e[0m" ; done ; echo
    cat << "EOF"
 __   __   __  __     __         __   __     ______     __  __     ______     ______    
/\ \ / /  /\ \/\ \   /\ \       /\ "-.\ \   /\  ___\   /\ \_\ \   /\  ___\   /\  == \   
\ \ \'/   \ \ \_\ \  \ \ \____  \ \ \-.  \  \ \ \____  \ \  __ \  \ \  __\   \ \  __<   
 \ \__|    \ \_____\  \ \_____\  \ \_  "\_\  \ \_____\  \ \_\ \_\  \ \_____\  \ \_\ \_\ 
  \/_/      \/_____/   \/_____/   \/_/ \/_/   \/_____/   \/_/\/_/   \/_____/   \/_/ /_/ 
EOF
    for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m──\e[0m" ; done ; echo 
    echo -e "$RED [!] I need a fucking domain dumbass "
    echo -e "$RED [!] cool.sh <url> <domain> you fucking dumbass"
    echo -e "$RED [!] clear ; ./cools.sh http://testphp.vulnweb.com/listproducts.php?cat=1 testphp.vulnweb.com"
    exit 1
fi




for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m──\e[0m" ; done ; echo
python3 banner.py
for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m──\e[0m" ; done ; echo
echo -e "[~] Targeting Domain ->  $domain"
FILES=("item_id=15")
for ELEMENT in ${FILES[@]}
do
echo -e "[~] Fixed URL -> $domain $FILES"
echo -e "[!] Trying Payload ${FILES}"
URL="http://google.com/search?hl=en&safe=off&q="
STRING=`echo $domain | sed 's/ /%20/g'`
URI="$URL%22$domain%22"
lynx -dump $URI > gone.tmp
sed 's/http/\^http/g' gone.tmp | tr -s "^" "\n" | grep http| sed 's/\ .*//g' > gtwo.tmp
rm gone.tmp
sed '/google.com/d' gtwo.tmp > urls
rm gtwo.tmp
echo "SExtraction -> Extracted `wc -l urls` and listed them in '`pwd`/urls' file for reference."
echo ""
cat urls
done 
FILES1=("cat=1")
for ELEMENT in ${FILES1[@]}
do
echo -e "[~] Fixed URL -> $domain $FILES"
echo -e "[!] Trying Payload ${FILES1}"
URL="http://google.com/search?hl=en&safe=off&q="
STRING=`echo $domain | sed 's/ /%20/g'`
URI="$URL%22$domain%22"
lynx -dump $URI > gone.tmp
sed 's/http/\^http/g' gone.tmp | tr -s "^" "\n" | grep http| sed 's/\ .*//g' > gtwo.tmp
rm gone.tmp
sed '/google.com/d' gtwo.tmp > urls
rm gtwo.tmp
echo "SExtraction -> Extracted `wc -l urls` and listed them in '`pwd`/urls' file for reference."
echo ""
cat urls
done 
echo '====================================================================================================='
echo '============================================ RUNNING SQL TESTS======================================='
python3 sql.py 
echo '====================================================================================================='
echo '============================================ RUNNING XSS TESTS======================================='
python3 xss.py 
echo '==============================================RUNNING DEFUALT DOMAIN HUNTING=========================='
ruby dom-red.rb $domain





################################################################################### YOUR ADDED SCRIPTS AND AUTOMATIOn ============================================
working_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
results_dir=$working_dir/results
# setting up directories for recon tool
echo "[+] Setting Up Enviornment"
if [ ! -d "$results_dir" ]
then
   mkdir $results_dir
fi
# enumeration proccess using tools from install script
echo "$red[+] Starting Nmap Scan$white"
nmap -sV -sC $domain1 -oA $results_dir/$domain1-tcp-scan --open
nmap -sV -sS $domain1 -oA $results_dir/$domain1-udp-scan --open 
echo "$red[+] Starting Sublist3r$white"
sublist3r -d $domain1 -o $results_dir/subdomains.txt 
echo "$red[+] Starting Subzy Takeover$white"
subzy -targets $results_dir/subdomains.txt > $results_dir/takeover.txt
echo "$red[+] Starting Nikto Scan$white"
nikto -h $domain1 -o $results_dir/nikto.txt
echo "$red[+] Starting Domain Brute Force$white"
gobuster dir -u $domain1 -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt -o $results_dir/server-dirs.txt
echo "$red[+] Starting Amass$white"
amass enum -d $domain1 -o $results_dir/amass.txt -r 8.8.8.8
echo "$red[+] Starting SSL Scans$white"
sslyze --regular $domain1 > $results_dir/sslyze-regular.txt
sslyze --heartbleed $domain1 > $results_dir/sslyze-heartbleed.txt
sslyze --robot $domain1 > $results_dir/sslyze-robot.txt
echo "$red[+] Starting Nuclei Scans$white"
nuclei -u $domain1 -o $results_dir/nuclei.txt
echo "$red[+] Running Wordpress Scans$white"
wpscan --url $domain1 -o $results_dir/wordpress.txt --no-banner
echo "$red[+] Script Done!"
