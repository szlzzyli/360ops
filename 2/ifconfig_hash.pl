#!/usr/bin/perl -w
#ifconfig_hash.pl


my @result;
@result = `ifconfig | awk '/eth/{inter=\$1;getline; split(\$2,x,":"); print inter, x[2]}'`;

my @tmp;
my %ifconfig_hash;

#my @inter;
#my @ip;
#@inter = `ifconfig | awk '/eth/{inter=\$1;getline; split(\$2,x,":"); print inter}'`;
#@ip = `ifconfig | awk '/eth/{inter=\$1;getline; split(\$2,x,":"); print x[2]}'`;
for my $i(0 .. $#result)
{
	@tmp = split(/ /,@result[$i]);
	$tmp_ref = @tmp;
	$ifconfig_hash{@tmp[0]} = @tmp[1];
#	$ifconfig_hash{$inter[$i]} = $ip[$i];
}

while(($key, $value) = each %ifconfig_hash)
{
	print "$key => $value\n";
}


