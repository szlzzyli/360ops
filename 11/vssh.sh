#!/bin/bash
#vssh.sh
# 11.vssh：在对单台机器做操作时我们经常会用“ssh ip”的方式登录到一台服务器上，
# 能不能编写这样一个工具vssh ip1,ip2,...ipn来模拟登录到n台服务器，
# 登录后所有操作相当于同时对n台服务器生效。


tmpfile=$(tempfile)

while [[ 1 ]]; do
	printf "please enter commond:"
	read cmd
	i=1
	for ip in $@; do
		if [[ $i -eq `expr $# + 1` ]]; then
			break;
		fi		
		ssh $ip $cmd  &> $tmpfile
		if [[ $? -eq 0 ]]; then
			printf "ip: $ip return information: \n"
			cat $tmpfile
		else
			((failed++))
			printf "ip: $ip cannot execute commond: $cmd !\n"
		fi
		((i++))
	done
done





