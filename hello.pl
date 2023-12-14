use strict;
use warnings;
use 5.32.1;

use OpenGL qw(GLUT_RGB GL_COLOR_BUFFER_BIT);

# 14-12-2023

$| = 1;

sub display_callback {
	OpenGL::glClear(GL_COLOR_BUFFER_BIT);
	OpenGL::glColor3f(1, 1, 1);

	# your drawing code here
	
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
OpenGL::glutInitWindowSize(400, 500);

my $window = OpenGL::glutCreateWindow("Hello");

if (!$window) {
	print "Failed to open GLUT Window.";
	exit;
}


OpenGL::glClearColor(0, 0, 0, 1);
OpenGL::gluOrtho2D(0, 400, 0, 500);

OpenGL::glutDisplayFunc \&display_callback;
# https://stackoverflow.com/questions/7237746/
OpenGL::glutKeyboardFunc \&key_callback;

OpenGL::glutMainLoop;
