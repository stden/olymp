{$H+,C+}

uses SysUtils;

type integer = longint;

const FNAME = 'sum';

function i2s( x: integer ): string;

	var s: string;

	begin
		str( x, s );
		i2s := s;
	end;

var line: integer;

procedure read3Integers( var a, b, c: integer; minA, maxA, minB, maxB, minC, maxC: integer );

	var r, min, max: array[ 0 .. 2 ] of integer;
		i: integer;
		ch: char;

	begin
		min[0] := minA; min[1] := minB; min[2] := minC;
		max[0] := maxA; max[1] := maxB; max[2] := maxC;
		inc( line );
		for i := 0 to 2 do begin
			assert( not EOLn, i2s( line ) + ': not enough numbers in a line' );
			read( ch );
			assert( ( ch >= '0' ) and ( ch <= '9' ), i2s( line ) + ': wrong format of a line' );
			r[i] := 0;
			repeat
				assert( ( max[i] - ( ord( ch ) - ord( '0' ) ) ) div 10 >= r[i], i2s( line ) + ': too large number at ' + i2s( i + 1 ) );
				r[i] := r[i] * 10 + ord( ch ) - ord( '0' );
				if ( EOLn ) then break;
				read( ch );
			until ( ( ch < '0' ) or ( ch > '9' ) );
			assert( EOLn or ( ch = ' ' ), i2s( line ) + ': wrong format of a line' );
			assert( r[i] >= min[i], i2s( line ) + ': too small number at ' + i2s( i + 1 ) );
		end;
		a := r[0];
		b := r[1];
		c := r[2];
		assert( EOLn and ( ch >= '0' ) and ( ch <= '9' ), i2s( line ) + ': extra information in a line' );
		assert( not EOF, i2s( line ) + ': no newline' );
		readln;
	end;

var n, k, m, o, l, r, i: integer;

begin
	assign( input, FNAME + '.in' ); reset( input );
	assign( output, FNAME + '.out' ); rewrite( output );
	line := 0;
	read3Integers( n, k, m, 1, 100000, 2, 5, 1, 100000 );
	writeln( n, ' ', k, ' ', m );
	for i := 1 to m do begin
		read3Integers( o, l, r, 1, 2, 1, n, 1, n );
		writeln( o, ' ', l, ' ', r );
		assert( l <= r, i2s( line ) + ': incorrect interval' );
	end;
	assert( EOF, i2s( line + 1 ) + ': extra lines in a file' );
	writeln( 3 );
	writeln( 2 );
	writeln( 1 );
	writeln( 1 );
end.
