#!/usr/bin/perl
use strict;
use warnings;
use POSIX;



defined (my $pid = fork()) or die "Can't fork: $!\n";
if ($pid)
{
	print "This is parent and now exit\n";
	exit;
}


POSIX::setsid() or die "Can't start a new session: $!\n";
chdir '/root/360ops/6';
my $rm_code = `echo "0 * * * * rm -f /root/360ops/6/cpu_info.log" > /var/spool/cron/root`;
system ($rm_code);



if(-t STDIN)
{
	close STDIN;
	open STDIN,'/dev/null' or die "Can't reopen STDIN to /dev/null: $!\n";
}
if(-t STDOUT)
{
	close STDOUT;
	open STDOUT,'>','/dev/null' or die "Can't reopen STDOUT to /dev/null: #$!\n";
}
if(-t STDERR)
{
	close STDERR;
	open STDERR,'>','/dev/null' or die "Can't reopen STDERR to /dev/null: $!\n";
}


system("./cpu_info.pl");


my $code = system("perl ./cpu_info.pl");

while(1)
{
	run_fork{
			child{
				eval($code);
				if($@){
					ERROR $@;
					}
				exit;
			}
			parent{
				my $childPid = shift;
				waitpid $childPid,0;
			}
	};
	sleep 1800;
}



