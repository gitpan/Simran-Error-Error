##################################################################################################################
# 
# Source  : $Source: /home/simran/cvs/cpan/Simran/Error/Error.pm,v $
# Revision: $Revision: 1.2 $ 
# Date    : $Date: 2000/04/26 04:28:08 $
# Author  : $Author: simran $
#
##################################################################################################################

package Simran::Error::Error;

use strict;
use Carp; 

($Simran::Error::Error::VERSION = '$Revision: 1.2 $') =~ s/[^\d\.]//g;

1;
 
##################################################################################################################

sub new {
  my $proto = shift;
  my $args  = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};
  
  $self->{"ERROR"} = undef;
  $self->{"CARP"}  = undef;
  $self->{"HISTORY"} = [];
  
  foreach (keys %{$args}) {
    my $property = uc($_);
    
    if (! exists($self->{"$property"})) {
      carp "Property $property not defined: $!\n";
      next;
    }
    else {
      $self->{"$property"} = $args->{"$_"};
    } 
  }
  
  bless ($self, $class);
  return $self;	
}


##################################################################################################################


sub clear {
  my $self = shift;
  $self->{"ERROR"} = undef;
}

##################################################################################################################

sub set {
  my $self = shift;
  $self->{"ERROR"} = "@_";
  push(@{$self->{"HISTORY"}}, $self->{"ERROR"});
  carp "$self->{ERROR}\n"  if ($self->{"CARP"});
}

##################################################################################################################

sub msg {
  my $self = shift;

  if (wantarray) {
    return @{$self->{"HISTORY"}};
  }
  return $self->{"ERROR"};
}

##################################################################################################################


__END__

=pod

##################################################################################################################

=head1 NAME 

Error.pm - Error Module

##################################################################################################################

=head1 DESCRIPTION

Gives a friendly interface for scripts and other modules to maintain error states

##################################################################################################################

=head1 SYNOPSIS

Please see DESCRIPTION.

##################################################################################################################

=head1 REVISION

$Revision: 1.2 $

$Date: 2000/04/26 04:28:08 $

##################################################################################################################

=head1 AUTHOR

Simran I<simran@unsw.edu.au>

##################################################################################################################

=head1 BUGS

No known bugs. 

##################################################################################################################

=head1 PROPERTIES

ERROR:    the error message - used internally

CARP:     should be set to '1' if you want the error module to 'carp' every time
          an error is set.

HISTORY:  a pointer to an array in which the full history of error messages is kept.

##################################################################################################################

=head1 METHODS

##################################################################################################################

=head2 new

=over

=item Description

This is the create method for the Error class. The new method can be
called with a reference to a hash, if it is, the reference is used to set
all properties contained in the hash. 

        $error = Error->new();

        or

        $error = Error->new($parameters_ref)

eg.

        $error = Error->new({CARP => 1});

=item Input

        $parameters_ref - a reference to a hash

=item Output

        New Error object created.

=item Return Value

        New Error object.

=back


##################################################################################################################

=head2 clear

=over

=item Description

This method resets the error message. It should be called at the start of 
any code that you want to set errors in. 

=item Syntax

        $session->clear();


=item Input

        None, uses object properties

=item Output

        none

=item Return Value

        none

=back



##################################################################################################################

=head2 set

=over

=item Description

Sets the error message to the supplied message. 

eg. $error->set("Could not open file : $!";

=item Input

        $string - the error message

=item Output

        none

=item Return Value

        none

=back


##################################################################################################################

=head2 msg

=over

=item Description

Returns a error message(s) that would have been set earlier. 

eg. 
        $message = $error->msg();

        @messages = $error->msg();


=item Input

        None

=item Output

        In array context, returns all the error messages set thus far.
        In scalar context, returns the lasest set error message.

=item Return Value

        same as output

=back



=cut




