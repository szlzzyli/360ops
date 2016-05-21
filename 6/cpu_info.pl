#!/usr/bin/perl -w
#cpu_info.pl






my $top_3 = `ps -eo pcpu,pid,user,args | sort -k 1 -r | head -4`;  #top 3
my $cpu_info = `top -n 1 -b | stdbuf -o0 grep "Cpu"`;
print $cpu_info;
print $top_3;

my $filename = 'cpu_info.log';
open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
print $fh `date`;
print $fh $cpu_info;
print $fh $top_3;
print $fh "----------------------------------------\n";
close $fh;

