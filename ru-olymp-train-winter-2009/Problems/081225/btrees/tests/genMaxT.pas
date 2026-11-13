{$C+,Q+,R+}

uses SysUtils;

const n: array[ 1 .. 24 ] of integer = ( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 499, 500 );

var tn, i: integer;
	s: string;

begin
	tn := strToInt( paramStr( 1 ) );
	for i := 1 to 24 do begin
		s := intToStr( tn );
		while ( length( s ) < 3 ) do s := '0' + s;
		assign( output, s ); rewrite( output );
		writeln( n[i], ' 1000000000' );
		close( output );
		inc( tn );
	end;
	assert( tn = strToInt( paramStr( 2 ) ) + 1, 'wrong parameters' );
end.