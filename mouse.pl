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

sub display_callback {
	OpenGL::glClear(GL_COLOR_BUFFER_BIT);

	# your drawing code here

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
	OpenGL::glRasterPos2i(10, 10);  # from lower left corner

	# https://stackoverflow.com/questions/538661/
	OpenGL::glutBitmapString(
		$font,
		sprintf("Mouse position: %d, %d", $mx, $my));

	# Restore the matrices
	OpenGL::glMatrixMode(GL_MODELVIEW);
	OpenGL::glPopMatrix();

	OpenGL::glMatrixMode(GL_PROJECTION);
	OpenGL::glPopMatrix();
	
	
	OpenGL::glEnd;
	OpenGL::glFlush;
}

sub mouse_callback {
	my ($x, $y) = @_;

	$mx = $x;
	$my = $y;
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

my $window = OpenGL::glutCreateWindow("Hello");

if (!$window) {
	print "Failed to open GLUT Window.";
	exit;
}


OpenGL::glClearColor(0, 0, 0, 1);
OpenGL::gluOrtho2D(0, $ww, 0, $wh);

OpenGL::glutDisplayFunc \&display_callback;
# https://stackoverflow.com/questions/7237746/
OpenGL::glutKeyboardFunc \&key_callback;

# https://community.khronos.org/t/get-mouse-cursor-with-glut/29082
OpenGL::glutPassiveMotionFunc \&mouse_callback;

OpenGL::glutMainLoop;
