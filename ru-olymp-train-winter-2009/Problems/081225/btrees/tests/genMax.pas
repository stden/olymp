{$C+,Q+,R+}

uses SysUtils;

const
	n: array[ 1 .. 4 ] of integer = ( 1, 10, 100, 500 );

var tn, i: integer;
	s: string;

begin
	tn := strToInt( paramStr( 1 ) );
	for i := 1 to 4 do begin
		s := intToStr( tn );
		while ( length( s ) < 2 ) do s := '0' + s;
		assign( output, s ); rewrite( output );
		writeln( n[i], ' 1000000000' );
		close( output );
		inc( tn );
	end;
	for i := 2 to 23 do begin
		s := intToStr( tn );
		while ( length( s ) < 2 ) do s := '0' + s;
		assign( output, s ); rewrite( output );
		writeln( '500 ', i );
		close( output );
		inc( tn );
	end;
	assert( tn = strToInt( paramStr( 2 ) ) + 1, 'wrong parameters' );
end.
