use Pod::Checker;
use Test::More tests => 4;

my ($c, $res);

$c = new Pod::Checker '-warnings' => 0;
ok($c);

$res = $c->parse_from_file('lib/Net/Zemanta/Suggest.pm', \*STDERR);
if ($res == -1) {
	warn "No POD data found in Net::Zemanta::Suggest\n";
}
ok(!$res);
$res = $c->parse_from_file('lib/Net/Zemanta/Preferences.pm', \*STDERR);
if ($res == -1) {
	warn "No POD data found in Net::Zemanta::Preferences\n";
}
ok(!$res);
ok($c->num_errors() == 0 && $c->num_warnings() == 0);
