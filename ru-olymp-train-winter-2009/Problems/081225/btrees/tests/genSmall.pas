{$C+,Q+,R+}

uses SysUtils;

var tn, t, n: integer;
	s: string;

begin
	tn := strToInt( paramStr( 1 ) );
	for t := 2 to 5 do
		for n := t - 1 to 5 do begin
			if ( n = 4 ) and ( t = 2 ) then continue;
			s := intToStr( tn );
			while ( length( s ) < 2 ) do s := '0' + s;
			assign( output, s ); rewrite( output );
			writeln( n, ' ', t );
			close( output );
			inc( tn );
		end;
	assert( tn = strToInt( paramStr( 2 ) ) + 1, 'wrong parameters' );
end.