package Net::Zemanta::Suggest;

=encoding utf8

=head1 NAME

Net::Zemanta::Suggest - Perl interface to Zemanta Suggest service

=cut

use warnings;
use strict;

use Net::Zemanta::Method;
our @ISA = qw(Net::Zemanta::Method);

=head1 SYNOPSIS

	use Net::Zemanta::Suggest;

	my $zemanta = Net::Zemanta::Suggest->new(
			APIKEY => 'your-API-key' 
		);

	my $suggestions = $zemanta->suggest(
			"Cozy lummox gives smart squid who asks for job pen."
		);

	# Suggested images
	for $image (@{$suggestions->{images}}) {
		$image->{url_m};
		$image->{description};
	}

	# Related articles
	for $article (@{$suggestions->{articles}}) {
		$article->{url};
		$article->{title};
	}

	# In-text links
	for $link (@{$suggestions->{markup}->{links}}) {
		for $target (@{$link->{target}}) {
			$link->{anchor}, " -> ", $target->{url};
		}
	}

	# Keywords
	for $keyword (@{$suggestions->{keywords}}) {
		$keyword->{name};
	}

=head1 METHODS

=over 8

=item B<new()>

	Net::Zemanta::Suggest->new(PARAM => ...);

Acceptable parameters:

=over 4

=item  APIKEY

The API key used for authentication with the service.

=item  USER_AGENT

If supplied the value is prepended to this module's identification string 
to become something like:

	your-killer-app/0.042 Perl-Net-Zemanta/0.1 libwww-perl/5.8

Otherwise just Net::Zemanta's user agent string will be sent.

=back

C<new()> returns C<undef> on error.

=cut

sub new {
	my $class 	= shift;
	my %params	= @_;

	$params{METHOD} = "zemanta.suggest";

	my $self = $class->SUPER::new(%params);

	return unless $self;

	bless ($self, $class);
	return $self;
}

=item B<suggest()>

	$suggestions = $zemanta->suggest( text )

Requests suggestions for the given text. Suggestions are returned as a tree
of hash and list references that correspond to the returned JSON data
structure.The most important elements are described bellow. For the full
reference see L<http://developer.zemanta.com>.

Returns C<undef> on error.

=over 8

=item B<articles>

Related articles. Contains a list of article objects, each having the following
elements:

=over 4

=item B<url>

URL of the article.

=item B<title>

Title of the article.

=item B<published_datetime>

Date when article was published in ISO 8601 format.

=back

=item B<keywords>

Suggested keywords. Contains a list of keyword objects, each having the
following elements:

=over 4

=item B<name>

Keyword name (may contain spaces)

=back

=item B<images>

Related images. Contains a list of image objects, each having the following
elements:

=over 4

=item B<url_l>, B<url_m>, B<url_s>

URLs of a large, medium and small version of the picture respectively.

=item B<image_source>

URL of a web page where more information about image can be found.

=item B<height>, B<width>

Dimensions of the large image.

=item B<license>

String containing license terms.

=item B<description>

String containing description

=item B<attribution>

Attribution that must be posted together with the image.

=back

=item B<markup>

An object containing the following elements:

=over 4

=item B<text>

HTML formatted input text with added in-text hyperlinks.

=item B<links>

Suggested in-text hyperlinks. A list of link objects, each having 
the following elements:

=over 4

=item B<anchor>

Word or phrase in the original text that should be used as the anchor for the
link.

=item B<target>

List of possible targets for this link. Each target has the following elements:

=over 4

=item B<url>

Destination URL.

=item B<type>

Type of the resource URL is pointing to.

=item B<title>

Title of the resource.

=back

=back

=back

=item B<rid>

Request ID.

=item B<signature>

HTML signature that should be appended to the text.

=back

=item B<error()>

If the last call to C<suggest()> returned an error, this function returns a
string containing a short description of the error. Otherwise it returns
C<undef>.

=back

=cut

sub suggest {
	my $self = shift;

	my ($text) = @_;

	my $text_utf8 = Encode::encode("utf8", $text);

	return $self->execute( text => $text_utf8 );
}

=head1 SEE ALSO

=over 4

=item * L<http://zemanta.com>

=item * L<http://developer.zemanta.com>

=back

=head1 AUTHOR

Tomaž Šolc E<lt>tomaz@zemanta.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Zemanta ltd.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.8.7 or, at your option,
any later version of Perl 5 you may have available.

=cut
