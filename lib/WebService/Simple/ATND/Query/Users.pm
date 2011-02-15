package WebService::Simple::ATND::Query::Users;
use strict;
use warnings;
use utf8;
use base qw(WebService::Simple::ATND::Query);


my @query_names = qw(
 event_id
 user_id
 nickname
 twitter_id
 owner_id
 owner_nickname
 owner_twitter_id
);

sub api_base { return "events/users/" }

sub query_names { return \@query_names; }

no strict 'refs';
for my $name (@query_names) {
    *{ "add_$name" } = sub {
        my ($self, $value) = @_;
        $self->{$name} = [] if ref $self->{$name} ne 'ARRAY';
        if (ref $value eq 'ARRAY') {
            push @{ $self->{$name} }, @$value;
        } else {
            push @{ $self->{$name} }, $value;
        }
        return $self;
    };
}

1;
