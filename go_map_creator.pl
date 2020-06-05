#!/usr/bin/perl

=head1 go_map_creator_est.pl v.2.0

=head1 Created

<2019 - fgonzale>
<email: fgonzale@lcg.unam.mx>

=head1 The program gets a gene-to-GO mapping from the GO_id_table of bioMart or GOslim of bioMart.

The user has to write
./go_map_creator_est.pl -t {input} > {output}

=cut
use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
my %opts = ();
GetOptions (\%opts,'t=s',
                   'h|help');
if(($opts{'h'}) || (scalar(keys(%opts)) == 0)){
   &PrintHelp();
}



open(MIFICH,$opts{t});
my %PH = ();
my @data = ();
while(<MIFICH>){
        if ($_!~"Gene stable ID"){ #skipe the first line
        $_ =~s/\t/,/g; #remplace tabs per "," (in case of separated tab format)
        @data=split(',',$_);#split the line by ','
                chomp $data[0];
                $data[1]=~s/\n//g;
                if(exists $PH{$data[0]}) {
                        $PH{$data[0]}[0] .=", $data[1]";
                }

                else {
                        $PH{$data[0]}[0]=$data[1];
                }

        }
}

my $dat = ();
foreach $dat (keys %PH) {
        print "$dat\t$PH{$dat}[0]\n"
        }

close(MIFICH);

sub PrintHelp {
   system "pod2text -c $0 ";
   exit();
