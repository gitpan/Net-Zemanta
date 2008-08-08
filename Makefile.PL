use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> 'Net::Zemanta',

	VERSION_FROM	=> 'lib/Net/Zemanta/Method.pm', 
	PREREQ_PM	=> {
				'LWP'	=> '5.09',
				'JSON'  => '2.00',
			},   

	($] >= 5.005 ?
		(ABSTRACT 	=> 'Perl bindings for services provided by Zemanta', 
		 AUTHOR		=> 'Tomaz Solc <tomaz@zemanta.com>') : ()),
);
