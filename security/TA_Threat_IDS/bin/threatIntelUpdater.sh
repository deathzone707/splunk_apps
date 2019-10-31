#!/bin/bash
unset LD_LIBRARY_PATH
DOWNLOAD_DIR="/tmp/threat_intel_download"

mkdir -p $DOWNLOAD_DIR


#==============================================================================
#Malc0de - Malc0de Blacklist
#==============================================================================

wget http://malc0de.com/bl/IP_Blacklist.txt -O /tmp/IP_Blacklist.txt --no-check-certificate -N
echo "# Generated: `date`" > $DOWNLOAD_DIR/ip_malc0de_black_list.txt
cat /tmp/IP_Blacklist.txt | sed -n '/^[0-9]/p' | sed 's/$/ Malc0de IP/' >> $DOWNLOAD_DIR/ip_malc0de_black_list.txt
rm /tmp/IP_Blacklist.txt

#==============================================================================
#Binary Defense Systems Artillery Threat Intelligence Feed and Banlist Feed
#==============================================================================

wget http://www.binarydefense.com/banlist.txt -O /tmp/binary_defense_ips.txt --no-check-certificate -N
echo "# Generated: `date`" > $DOWNLOAD_DIR/ip_binary_defense_ban_list.txt
cat /tmp/binary_defense_ips.txt | sed -n '/^[0-9]/p' | sed 's/$/ Binary Defense IP/' >> $DOWNLOAD_DIR/ip_binary_defense_ban_list.txt
rm /tmp/binary_defense_ips.txt

#==============================================================================
#AlienVault - IP Reputation Database
#==============================================================================

wget https://reputation.alienvault.com/reputation.snort.gz -P /tmp --no-check-certificate -N
gzip -d /tmp/reputation.snort.gz
echo "# Generated: `date`" > $DOWNLOAD_DIR/ip_av_rep_list.txt
cat /tmp/reputation.snort | sed -n '/^[0-9]/p' | sed "s/# //">> $DOWNLOAD_DIR/ip_av_rep_list.txt
rm /tmp/reputation.snort

#==============================================================================
#Ransomware Tracker - IP Block List
#==============================================================================

wget https://ransomwaretracker.abuse.ch/downloads/RW_IPBL.txt -O /tmp/ransomwaretracker.txt --no-check-certificate -N
echo "# Generated: `date`" > $DOWNLOAD_DIR/ip_ransomware_block_list.txt
cat /tmp/ransomwaretracker.txt | sed -n '/^[0-9]/p' | sed 's/$/ Ransomware IP/' >> $DOWNLOAD_DIR/ip_ransomware_block_list.txt
rm /tmp/ransomwaretracker.txt

#==============================================================================
#Ransomware Tracker - domain Block List
#==============================================================================

wget https://ransomwaretracker.abuse.ch/downloads/RW_DOMBL.txt -O /tmp/ransomwareDomainTracker.txt --no-check-certificate -N
echo "# Generated: `date`" > $DOWNLOAD_DIR/domain_ransomware_block_list.txt
cat /tmp/ransomwareDomainTracker.txt | sed  '/^#/d'| sed 's/$/ Ransomware Domain/' >> $DOWNLOAD_DIR/domain_ransomware_block_list.txt
rm /tmp/ransomwareDomainTracker.txt

#==============================================================================
#Ransomware Tracker - url Block List
#==============================================================================

wget https://ransomwaretracker.abuse.ch/downloads/RW_URLBL.txt -O /tmp/ransomwareURLTracker.txt --no-check-certificate -N
echo "# Generated: `date`" > $DOWNLOAD_DIR/url_ransomware_block_list.txt
cat /tmp/ransomwareURLTracker.txt | sed  '/^#/d'| sed 's/$/ Ransomware URL/' >> $DOWNLOAD_DIR/url_ransomware_block_list.txt
rm /tmp/ransomwareURLTracker.txt

#==============================================================================
#VirusShare Hash list
#==============================================================================

wget https://virusshare.com/hashes/VirusShare_00000.md5 -O /tmp/virussharehash.txt --no-check-certificate -N
echo "# Generated: `date`" > $DOWNLOAD_DIR/hash_virusshare_list.txt
cat /tmp/virussharehash.txt | sed  '/^#/d'| sed 's/$/ Malware Hash/' >> $DOWNLOAD_DIR/hash_virusshare_list.txt
rm /tmp/virussharehash.txt


#==============================================================================
# Alexa 1 M
#==============================================================================

wget http://s3.amazonaws.com/alexa-static/top-1m.csv.zip -O /tmp/top-1m.csv.zip --no-check-certificate -N
unzip -o /tmp/top-1m.csv.zip -d /tmp/
cat /tmp/top-1m.csv > $DOWNLOAD_DIR/top-1m.csv
