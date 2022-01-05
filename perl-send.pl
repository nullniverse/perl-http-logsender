#!/usr/bin/perl

# Don't forget to install the libs first
use strict;
use warnings;
use File::Tail;
use LWP::UserAgent;

# Define your strict directory here e.g: /home
my $dir='/<your dir here>';

# Get the list of logfiles in the target directory for reading and sending
# Define your <target directory folder>, can be simplified if you wish. Kept this way for portable use in various folders in the same $dir
my @logfiles = glob("$dir/<target directory folder>/*.log");

# Format request and LWP params
my $ua  = LWP::UserAgent->new();
my $filename = 'filtered_status.log';

# Specify your endpoint HTTP destination 
# You can use as many URLs as you want 
my $uri1 = 'http://dummy-IP:PORT/PATH1';
my $uri2 = 'http://dummy-IP:PORT/PATH1';
		


# Set up an array of File::Tail objects, one for each filename.
my @logs=();
foreach (@logfiles) {
  push(@logs,File::Tail->new(name => $_)); # Beware! Using -1 will read the ENTIRE log file!!!
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
	    
      # The 'if' below can select to send just the specific line matched by the regex, in this case containing the 'ROUTING_TABLE' text
      # Use as many matches as you want

      # The commented line below gets the filename of the current File::Tail object if you wish, for later use in your final message
      # my $fn = $input->{'input'};
      
      if (m/ROUTING_TABLE/) {

		# POST message #1
		my $json = $lineval;
		print $lineval;
		my $req = HTTP::Request->new( 'POST', $uri1 );
		$req->header( 'Content-Type' => 'text/plain' );
		$req->content( $json );
		
		my $lwp = LWP::UserAgent->new;
		$lwp->request( $req );

      } elsif (m/CLIENT_LIST/) {
	  
		# POST message #2
		my $json = $lineval;
		print $lineval;
		my $req = HTTP::Request->new( 'POST', $uri2 );
		$req->header( 'Content-Type' => 'text/plain' );
		$req->content( $json );
		
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
