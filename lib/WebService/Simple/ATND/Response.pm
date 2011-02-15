package WebService::Simple::ATND::Response;
use strict;
use warnings;
our $VERSION = '0.01';


sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;

    return bless { %args }, $class;
}

sub parse_response {
    my ($class, $response) = @_;
    return $class->new($response->parse_response);
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
