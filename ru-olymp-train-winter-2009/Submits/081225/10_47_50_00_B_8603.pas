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

const
	MAXL = 25;
	BASE = 1000000000;
	LOG_BASE = 9;

type TLong = array[ 0 .. MAXL ] of integer;

procedure assignL( var a, b: TLong );

	begin
		a := b;
	end;

procedure assignL( var a: TLong; b: integer );

	begin
		fillChar( a, sizeOf( a ), 0 );
		a[0] := b;
		while ( a[0] >= BASE ) do begin
			dec( a[0], BASE );
			inc( a[1] );
		end;
		assert( a[1] < BASE );
	end;

procedure incL( var a, b: TLong );

	var i, cy: integer;

	begin
		cy := 0;
		for i := 0 to MAXL do begin
			inc( a[i], b[i] + cy );
			if ( a[i] >= BASE ) then begin
				a[i] -= BASE;
				cy := 1;
			end else cy := 0;
		end;
		assert( cy = 0, 'TLong overflow' );
	end;

procedure mulL( var a, b, c: TLong );

	var i, j: integer;
		cy, t: int64;

	begin
		cy := 0;
		for i := 0 to MAXL do begin
			for j := 0 to i do inc( cy, int64( a[j] ) * b[i - j] );
			t := cy div BASE;
			c[i] := integer( cy - t * BASE );
			cy := t;
		end;
		assert( cy = 0, 'TLong overflow' );
		for i := 0 to MAXL do for j := MAXL - i + 1 to MAXL do
			assert( ( a[i] = 0 ) or ( b[j] = 0 ), 'TLong overflow' );
	end;

function isZero( var a: TLong ): boolean;

	var i: integer;

	begin
		isZero := true;
		for i := 0 to MAXL do if ( a[i] <> 0 ) then begin
			isZero := false;
			exit;
		end;
	end;

procedure writeL( var a: TLong );

	var i: integer;
		s: string;

	begin
		i := MAXL;
		while ( i > 0 ) and ( a[i] = 0 ) do dec( i );
		write( a[i] );
		while ( i > 0 ) do begin
			dec( i );
			{str( a[i], s );}
			s := intToStr( a[i] );
			{writeln;
			write( a[i], ' "', s, '"' );}
			while ( length( s ) < LOG_BASE ) do s := '0' + s;
			write( s );
			{writeln( ' -> ', '"', s, '"' );}
		end;
	end;

procedure writelnL( var a: TLong );
	
	begin
		writeL( a ); writeln;
	end;

var r: array[ 0 .. 1, 1 .. MAXN ] of TLong;
	n, t, i, d, j, k: integer;
	res: TLong;
	a: array[ 1 .. MAXN ] of TLong;
	z: boolean;
	tmp: TLong;

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
	for i := t - 1 to 2 * t - 1 do assignL( r[0][i], 1 );
	d := 1;
	assignL( res, r[0][n] );
	if ( DEBUG >= 2 ) then begin
		writeln( 'depth ', d );
		for i := 1 to n do begin
			writeL( r[0][i] ); write( ' ' );
		end;
		writeln;
		writelnL( res );
	end;	
	z := false;
	while ( not z ) do begin
		fillChar( r[d and 1], sizeOf( r[d and 1] ), 0 );
		for i := 1 to n do assignL( a[i], r[( d - 1 ) and 1][i] );
		if ( 1 >= t ) then
			for j := 1 to n do incL( r[d and 1][j], a[j] );	
		for i := 2 to 2 * t do begin
			for j := n downto 1 do begin
				assignL( a[j], 0 );
				for k := j - 1 downto 1 do begin
					mulL( r[( d - 1 ) and 1][j - k], a[k], tmp );
					incL( a[j], tmp );
				end;	
			end;
			assignL( a[1], 0 );
			if ( DEBUG >= 4 ) then begin
				write( '	' );
				for j := 1 to n do begin
					writeL( a[j] ); write( ' ' );
				end;
				writeln;
			end;
			if ( i >= t ) then
				for j := 1 to n do incL( r[d and 1][j], a[j] );	
		end;
		incL( res, r[d and 1][n] );
		if ( DEBUG >= 2 ) then begin
			writeln( 'depth ', d );
			for i := 1 to n do begin
				writeL( r[d and 1][i] ); write( ' ' );
			end;
			writeln;
			writelnL( res );
		end;
		if ( DEBUG >= 1 ) then begin
			for i := 1 to n do begin
				writeL( r[d and 1][i] ); write( '	' );
			end;
			writeln;
		end;
		z := true;
		for i := 1 to n do z := z and isZero( r[d and 1][i] );
		inc( d );
	end;
	writelnL( res );
end.
