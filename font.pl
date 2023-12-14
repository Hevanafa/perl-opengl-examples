use strict;
use warnings;
use 5.32.1;

use OpenGL qw(GLUT_RGB GL_COLOR_BUFFER_BIT GLUT_BITMAP_9_BY_15
	GL_PROJECTION GL_MODELVIEW);

# 14-12-2023

$| = 1;

# https://stackoverflow.com/questions/14318/
our $font = GLUT_BITMAP_9_BY_15;
our ($ww, $wh) = (320, 240);
our ($mx, $my) = (0, 0);

sub is_prime {
	my $n = shift;
	my $flag = 0;

	return 0 if $n < 2;

	for my $i (2..int(sqrt $n) + 1) {
		if ($n % $i == 0) {
			$flag = 1;
			last
		}
	}

	!$flag
}

our @primes = grep { is_prime $_ } 1..100;
# print join " ", @primes;
print scalar @primes;
# exit;

sub draw_string {
	my ($text, $x, $y) = @_;

	# prepare the matrices for 2D rendering
	# https://stackoverflow.com/questions/14318/
	OpenGL::glMatrixMode(GL_PROJECTION);
	OpenGL::glPushMatrix();
	OpenGL::glLoadIdentity();
	OpenGL::gluOrtho2D(0, $ww, 0, $wh);

	OpenGL::glMatrixMode(GL_MODELVIEW);
	OpenGL::glPushMatrix();
	OpenGL::glLoadIdentity();

	# Draw the text
	OpenGL::glColor3f(0, 1, 0);  # green

	OpenGL::glRasterPos2i($x, $wh - $y);  # from lower left corner

	# https://stackoverflow.com/questions/538661/
	OpenGL::glutBitmapString($font, $text);

	# Restore the matrices
	OpenGL::glMatrixMode(GL_MODELVIEW);
	OpenGL::glPopMatrix();

	OpenGL::glMatrixMode(GL_PROJECTION);
	OpenGL::glPopMatrix();
}


sub display_callback {
	OpenGL::glClear(GL_COLOR_BUFFER_BIT);

	# your drawing code here

	draw_string("Prime numbers from 1 to 100:", 10, 15);

	for my $row (0..int(scalar(@primes) / 7)) {  # 7 items per row
		my @items = grep $_, @primes[$row * 7..$row * 7 + 6];  # grep undefined values

		draw_string(
			join(" ", @items),
			10, 30 + $row * 15);
	}

	draw_string("Press Q to exit", 10, $wh - 10);
	
	OpenGL::glEnd;
	OpenGL::glFlush;
}


sub key_callback {
	my ($key, $x, $y) = @_;
	
	# say $key;  # returns the ASCII code
	
	if ($key eq ord("q")) {
		exit 0;
	}
}


OpenGL::glutInit;

OpenGL::glutInitDisplayMode(GLUT_RGB);
OpenGL::glutInitWindowSize($ww, $wh);

my $window = OpenGL::glutCreateWindow("Prime Numbers from 1 to 100");

if (!$window) {
	print "Failed to open GLUT Window.";
	exit;
}


OpenGL::glClearColor(0, 0, 0, 1);
OpenGL::gluOrtho2D(0, $ww, 0, $wh);

OpenGL::glutDisplayFunc \&display_callback;
# https://stackoverflow.com/questions/7237746/
OpenGL::glutKeyboardFunc \&key_callback;

OpenGL::glutMainLoop;
