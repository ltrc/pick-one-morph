#/usr/bin/perl
use Dir::Self;
use lib __DIR__ . "/src";
use lib __DIR__ . "/API";
use Getopt::Long;
use pickonemorph;

GetOptions("help!"=>\$help,"input=s"=>\$input,"output:s",\$output);
print "Unprocessed by Getopt::Long\n" if $ARGV[0];
foreach (@ARGV) {
	print "$_\n";
	exit(0);
}
if($help eq 1)
{
	print "Pick One Morph - Pick One Morph Version 1.1\n     (23th September 2008)\n\n";
	print "usage : ./pickonemorph.pl [--input=\"input_file\"] [--output=\"output_file\"] \n";
	print "\tIf the output file is not mentioned then the output will be printed to STDOUT\n";
	exit(0);
}

if ($input eq "")
{
	$input="/dev/stdin";
}

pickonemorph($input, $output);
