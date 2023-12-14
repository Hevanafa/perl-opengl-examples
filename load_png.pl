use strict;
use warnings;
use 5.32.1;

# 14-12-2023

use Image::PNG::Libpng qw(read_png_file);

my $png = read_png_file("pomni.png");
my $IHDR = $png->get_IHDR();

printf "image width: %d\n", $IHDR->{width};
printf "image height: %d\n", $IHDR->{height};
