#!/usr/bin/expect

#If it all goes pear shaped the script will timeout after 20 seconds.
set timeout 20
#First argument is assigned to the variable name
set hostname [lindex $argv 0]
#Second argument is assigned to the variable password 
set password [lindex $argv 1]

#log_file -a ~/results.log

#This spawns the telnet program and connects it to the variable name
spawn telnet $hostname
#The script expects Password
expect "User Access Verification"
expect "Password:"
#The script sends the password variable
send "$password\n"
#This hands control of the keyboard over to you (Nice expect feature!)

send "enable\n"
expect "Password:"
send "$password\n"
expect "*#"
send "term len 0\n"
expect "*#"
#send "show vlan\n"
#expect "*#"
send "conf t\n"
expect "*#"
send "no errdisable detect cause gbic-invalid\n"
expect "*#"
send "service unsupported-transceiver\n"
expect "*#"
send "exit\n"
expect "*#"
send "wr\n"
#expect "Building configuration..."
#expect "[OK]"
expect "*#"
send "exit\n"
#interact
