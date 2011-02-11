package WebService::Simple::ATND::Query;
use strict;
use warnings;
use utf8;
use WebService::Simple::ATND::Query::Events;
use WebService::Simple::ATND::Query::Users;


my @query_names;


sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;

    $args{start} ||= 1;
    $args{count} ||= 10;

    bless \%args, $class;
}

sub create_events {
    my $class = shift;
    return WebService::Simple::ATND::Query::Events->new(@_);
}

sub create_users {
    my $class = shift;
    return WebService::Simple::ATND::Query::Users->new(@_);
}

sub query_names { return []; }

sub as_hashref {
    my ($self) = @_;

    my %hash;
    for my $name (@{ $self->query_names }) {
	if (ref $self->{$name} eq 'ARRAY' &&  @{ $self->{$name} }) {
	    $hash{$name} = $self->{$name};
	}
    }
    $hash{start} = $self->{start};
    $hash{count} = $self->{count};

    return \%hash;
}


1;
__END__

=head1 NAME

WebService::Simple::ATND::Query -

=head1 SYNOPSIS

  use WebService::Simple::ATND::Query;

=head1 DESCRIPTION

WebService::Simple::ATND::Query is a Query Builder for ATND API.

=head1 METHODS

=over 3

=item new(I<%args>)

=item new(I<%args>)

=item new(I<%args>)

=back

=head1 AUTHOR

memememomo E<lt>memememomo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
