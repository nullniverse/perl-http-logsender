#!/usr/bin/perl

use strict;
use warnings;
use File::Tail;
use LWP::UserAgent;
use Data::Dumper;

my $dir='/home/PROJECT_DIR';

# Get the list of *ALL* logfiles in the target directory
my @logfiles = glob("$dir/*.log");

# Format request and LWP params
my $ua  = LWP::UserAgent->new();
my $uri1 = '<ENDPOINT1-URL-OR-IP';
my $uri2 = '<ENDPOINT1-URL-OR-IP>';
# Format the header according to your needs
my $header = ['Content-Type' => 'application/json; charset=UTF-8', 'Authorization' => "Bearer TOKEN-HERE-IF-ANY"];


# Set up an array of File::Tail objects, one for each filename.
my @logs=();
foreach (@logfiles) {
  push(@logs,File::Tail->new(name => $_, tail => 1)); # Beware! Using -1 will read the ENTIRE log file!!!
}

# Now watch those logs and do stuff when the script sees matching patterns
while (1) {
  my ($nfound,$timeleft,@pending)= File::Tail::select(undef,undef,undef,undef,@logs);

  if ($nfound) {
    foreach my $input (@pending) {

      # read the line of data from the current File::Tail object into $_
      $_ = $input->read;
      chomp;
          
          # Define line variable and ascribe the new line found
          my $lineval=$_;
          
      # Get the filename of the current File::Tail object if you wish.
      # my $fn = $input->{'input'};

      # Remember to **comment** (#) PRINT if you plan to send a huge load of log information

      if (m/<LOG_MATCHING_PATTERN_NUMBER_ONE>/) {

                # POST message
                my $json = $lineval;
                print $lineval;

                my $req = HTTP::Request->new( 'POST', $uri1, $header);
                $req->content( $json );
                print Dumper($req);

                my $res = $ua->request($req);
                print Dumper($res->content);


                my $lwp = LWP::UserAgent->new;
                $lwp->request( $req );

      } elsif (m/<LOG_MATCHING_PATTERN_NUMBER_TWO>/) {
          
                # POST message
                my $json = $lineval;
                print $lineval;

                my $req = HTTP::Request->new( 'POST', $uri2, $header);
                $req->content( $json );
                print Dumper($req);

                my $res = $ua->request($req);
                print Dumper($res->content);

                my $lwp = LWP::UserAgent->new;
                $lwp->request( $req );

      } elsif (m/somestring999/) {
         # and here
      } elsif (m/somestring696/) {
         # yet more here
      }
    }
  }
};