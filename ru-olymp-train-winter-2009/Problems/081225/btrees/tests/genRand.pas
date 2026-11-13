{$C+,Q+,R+}

uses SysUtils, Math;

const
	MAXN = 500;
	MAXT = 1000000000;

var tn: integer;
	s: string;
	mt: longint;

begin
	randseed := strToInt( paramStr( 4 ) );
	tn := strToInt( paramStr( 1 ) );
	mt := max( 2, min( MAXT, strToInt( paramStr( 3 ) ) ) );
	repeat
		s := intToStr( tn );
		while ( length( s ) < 3 ) do s := '0' + s;
		assign( output, s ); rewrite( output );
		writeln( random( MAXN - 1 ) + 1, ' ', random( mt - 2 ) + 2 );
		close( output );
		inc( tn );
	until ( tn > strToInt( paramStr( 2 ) ) );
end.