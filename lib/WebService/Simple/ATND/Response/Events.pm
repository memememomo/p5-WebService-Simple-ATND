package WebService::Simple::ATND::Response::Events;
use strict;
use warnings;
use base qw(WebService::Simple::ATND::Response);

sub new {
    my ($class, $response) = @_;

    my $hash = $response->parse_response;
    my %res = %{ WebService::Simple::ATND::Response::_init_response($hash) };

    if (ref $hash->{events}->{event} ne 'ARRAY') {
        $hash->{events}->{event} = [$hash->{events}->{event}];
    }

    for my $e (@{ $hash->{events}->{event} }) {
        my %event;
        for my $name (qw(event_id title catch description event_url started_at ended_at url limit address place lat lon owner_id owner_nickname owner_twitter_id accepted waiting updated_at)) {
            if ( ref $e->{$name} eq 'HASH' ) {
                $event{$name} = $e->{$name}->{content};
            } else {
                $event{$name} = $e->{$name};
            }
        }
        push @{ $res{events} }, \%event;
    }

    return $class->SUPER::new({ %res });
}


1;
