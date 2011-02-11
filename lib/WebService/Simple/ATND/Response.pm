package WebService::Simple::ATND::Response;
use strict;
use warnings;
use WebService::Simple::ATND::Response::Events;
use WebService::Simple::ATND::Response::Users;
our $VERSION = '0.01';


sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;

    return bless { %args }, $class;
}

sub parse_events {
    my ($class, $response) = @_;
    return WebService::Simple::ATND::Response::Events->new($response);
}

sub parse_users {
    my ($class, $response) = @_;
    return WebService::Simple::ATND::Response::Users->new($response);
}


sub results_returned {
    my ($self) = @_;
    return $self->{results_returned};
}

sub results_start {
    my ($self) = @_;
    return $self->{results_start};
}

sub events {
    my ($self) = @_;
    return $self->{events};
}

sub _init_response {
    my ($hash) = @_;

    my %res = (
	results_returned => $hash->{results_returned}->{content},
	results_available => $hash->{results_available}->{content},
	events => [],
    );

    return \%res;
}


1;
__END__

=head1 NAME

WebService::Simple::ATND::Response -

=head1 SYNOPSIS

  use WebService::Simple::ATND::Response;

=head1 DESCRIPTION

WebService::Simple::ATND::Response is

=head1 AUTHOR

memememomo E<lt>memememomo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
