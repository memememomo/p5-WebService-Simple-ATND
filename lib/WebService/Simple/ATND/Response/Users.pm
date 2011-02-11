package WebService::Simple::ATND::Response::Users;
use strict;
use warnings;
use base qw(WebService::Simple::ATND::Response);
use Data::Dumper;


sub new {
    my ($class, $response) = @_;

    my $hash = $response->parse_response;
    my %res = %{ WebService::Simple::ATND::Response::_init_response($hash) };

    if (ref $hash->{events}->{event} ne 'ARRAY') {
        $hash->{events}->{event} = [$hash->{events}->{event}];
    }

    for my $e (@{ $hash->{events}->{event} }) {
        my %event;
        for my $name (qw(event_id title event_url limit accepted waiting updated_at)) {
            if ( ref $e->{$name} eq 'HASH' ) {
                $event{$name} = $e->{$name}->{content};
            } else {
                $event{$name} = $e->{$name};
            }
        }

        $event{users} = [];
        if (ref $e->{users}->{user} eq 'ARRAY') {
            for my $u (@{ $e->{users}->{user} }) {
                my %users;
                for my $name (qw(user_id nickname twitter_id status)) {
                    if ( ref $u->{$name} eq 'HASH' ) {
                        $users{$name} = $u->{$name}->{content};
                    } else {
                        $users{$name} = $u->{$name};
                    }
                }
                push @{ $event{users} }, \%users;
            }
        }

        push @{ $res{events} }, \%event;
    }

    return $class->SUPER::new({ %res });
}


1;
