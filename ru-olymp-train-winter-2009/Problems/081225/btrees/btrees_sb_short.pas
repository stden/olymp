{$C+,Q+,R+}

uses SysUtils;

type integer = longint;

const
	MAXN = 500;
	DEBUG = 0;

procedure read2Integers( var a, b: integer; minA, maxA, minB, maxB: integer );

	var r, max: array[ 1 .. 2 ] of integer;
		c: char;
		i: integer;

	begin
		max[1] := maxA; max[2] := maxB;
		for i := 1 to 2 do begin
			assert( not EOLn, 'Unexpected EOLn' );
			read( c ); assert( ( c >= '0' ) and ( c <= '9' ), 'Wrong format' );
			r[i] := 0;
			repeat
				assert( ( max[i] - ( ord( c ) - ord( '0' ) ) ) / 10 >= r[i], 'Too big number' );
				r[i] := r[i] * 10 + ord( c ) - ord( '0' );
				assert( r[i] <= max[i], 'Too big number' );
				if ( EOLn ) then break;
				read( c );
			until ( c < '0' ) or ( c > '9' );
			if ( i < 2 ) then assert( c = ' ', 'Wrong format: space expected' )
			else assert( ( c >= '0' ) and ( c <= '9' ) and EOLn, 'EOLn expected' );
		end;
		a := r[1]; assert( ( a >= minA ) and ( a <= maxA ), 'First number not in range' );
		b := r[2]; assert( ( b >= minB ) and ( b <= maxB ), 'Second number not in range' );
		assert( not EOF, 'Newline expected' );
		readln; assert( EOF, 'Extra info in file' );
	end;

var r: array[ 0 .. 1, 1 .. MAXN ] of int64;
	n, t, i, d, j, k: integer;
	res: int64;
	a: array[ 1 .. MAXN ] of int64;
	z: boolean;

begin
	assign( input, 'btrees.in' ); reset( input );
	assign( output, 'btrees.out' ); rewrite( output );
	read2Integers( n, t, 1, MAXN, 2, 1000000000 );
	if ( t * int64( t ) - t > n ) then begin
		if ( t - 1 <= n ) and ( n <= 2 * t - 1 ) then writeln( '1' )
		else writeln( '0' );
		exit;
	end;
	fillChar( r, sizeOf( r ), 0 );
	for i := t - 1 to 2 * t - 1 do r[0][i] := 1;
	d := 1;
	res := r[0][n];
	if ( DEBUG >= 2 ) then begin
		writeln( 'depth ', d );
		for i := 1 to n do write( r[0][i], ' ' );
		writeln;
			writeln( res );
	end;	
	z := false;
	while ( not z ) do begin
		fillChar( r[d and 1], sizeOf( r[d and 1] ), 0 );
		for i := 1 to n do a[i] := r[( d - 1 ) and 1][i];
		if ( 1 >= t ) then
			for j := 1 to n do inc( r[d and 1][j], a[j] );	
		for i := 2 to 2 * t do begin
			for j := n downto 1 do begin
				a[j] := 0;
				for k := j - 1 downto 1 do inc( a[j], r[( d - 1 ) and 1][j - k] * a[k] );
			end;
			a[1] := 0;
			if ( DEBUG >= 4 ) then begin
				write( '	' );
				for j := 1 to n do write( a[j], ' ' );
				writeln;
			end;
			if ( i >= t ) then
				for j := 1 to n do inc( r[d and 1][j], a[j] );	
		end;
		inc( res, r[d and 1][n] );
		if ( DEBUG >= 2 ) then begin
			writeln( 'depth ', d );
			for i := 1 to n do write( r[d and 1][i], ' ' );
			writeln;
			writeln( res );
		end;
		z := true;
		for i := 1 to n do z := z and ( r[d and 1][i] = 0 );
		inc( d );
	end;
	writeln( res );
end.
