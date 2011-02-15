use strict;
use utf8;
use Test::More;
use Time::Piece;
use WebService::Simple::ATND;
use Data::Dumper;

my $atnd = WebService::Simple::ATND->new;
#$atnd->{debug} = 1;

{
    my $test_date = Time::Piece->strptime('2011-01-01 00:00:00', '%Y-%m-%d %H:%M:%S');
    my $query = WebService::Simple::ATND->query_events();
    $query->add_ym($test_date->strftime('%Y%m'));

    my $res = $atnd->get($query);
 
    for my $event (@{ $res->events }) {
        my $started_at = $event->{started_at};
        $started_at =~ s/\+.+$//;

        my $ended_at = $event->{ended_at};
        $ended_at =~ s/\+.+$//;

        $started_at = Time::Piece->strptime($started_at, '%Y-%m-%dT%H:%M:%S')->strftime('%Y%m');
        $ended_at   = Time::Piece->strptime($ended_at, '%Y-%m-%dT%H:%M:%S')->strftime('%Y%m');

        ok($started_at <= $test_date->strftime('%Y%m') && $test_date->strftime('%Y%m') <= $ended_at, "$started_at, $ended_at");
    }
}

{
    my $query = WebService::Simple::ATND->query_events();
    $query->add_keyword(['perl', 'php']);

    my $res = $atnd->get($query);

    my $count = @{ $res->events };
    ok($count > 0, "count");

    for my $event (@{ $res->events }) {
        my $text = join('', $event->{title},
                        $event->{description},
                        $event->{catch},
                        $event->{address});
        like($text, qr/perl/i, "not found keyword(perl)");
        like($text, qr/php/i, "not found keyword(php)");
    }
}

{
    my $query = WebService::Simple::ATND->query_events();
    $query->add_keyword('perl');
    $query->add_keyword('php');

    my $res = $atnd->get($query);

    my $count = @{ $res->events };
    ok($count > 0, "count");

    for my $event (@{ $res->events }) {
        my $text = join('', $event->{title},
                        $event->{description},
                        $event->{catch},
                        $event->{address});
        like($text, qr/perl/i, "not found keyword(perl)");
        like($text, qr/php/i, "not found keyword(php)");
    }
}

{
    my $query = WebService::Simple::ATND->query_events();
    $query->add_event_id('1');

    my $res = $atnd->get($query);

    like($res->events->[0]->{title}, qr/ATNDデモイベント/, "events_event_id");
}

{
    my $query = WebService::Simple::ATND->query_users();
    $query->add_event_id('1');

    my $res = $atnd->get($query);

    like($res->events->[0]->{title}, qr/ATNDデモイベント/, "users_event_id");
    ok(ref $res->events->[0]->{users} eq 'ARRAY');
}

done_testing();
