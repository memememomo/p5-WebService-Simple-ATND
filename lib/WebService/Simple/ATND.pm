package WebService::Simple::ATND;
use strict;
use warnings;
use utf8;
use base qw(WebService::Simple);
use WebService::Simple::ATND::Response;

our $VERSION = '0.01';

__PACKAGE__->config(
    base_url => "http://api.atnd.org/",
);

sub get {
    my ($self, $query) = @_;

    $query->{format} = 'xml';

    if ( ref $query eq 'WebService::Simple::ATND::Query::Events' ) {
        return WebService::Simple::ATND::Response->parse_events(
            $self->SUPER::get("events/", $query->as_hashref)
        );
    } elsif ( ref $query eq 'WebService::Simple::ATND::Query::Users' ) {
        return WebService::Simple::ATND::Response->parse_users(
            $self->SUPER::get("events/users/", $query->as_hashref)
        );
    } else {
        return undef;
    }
}

1;
__END__

=head1 NAME

WebService::Simple::ATND -

=head1 SYNOPSIS

  use WebService::Simple::ATND;

=head1 DESCRIPTION

WebService::Simple::ATND is a simple class to interact with ATND API.

=head1 METHODS

=over 3

=item new(I<%args>)

=item events(I<$query>)

=item users(I<$query>)

=back

=head1 AUTHOR

memememomo E<lt>memememomo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
