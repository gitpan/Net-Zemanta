BEGIN {
	eval 'use Test::Pod::Coverage tests => 1';
	if ($@) {
		use Test;
		plan tests => 1;
		skip('Test::Pod::Coverage not found');
		exit(0);
	}
}

pod_coverage_ok('Net::Zemanta');
