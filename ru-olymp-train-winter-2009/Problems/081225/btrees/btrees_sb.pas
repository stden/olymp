{$C+,Q-,R-}

uses SysUtils, Math;

type integer = longint;

const
	MAXN = 500;

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
	MAXL = 56;
	BASE = 10000;
	LOG_BASE = 4;

type TLong = array[ 0 .. MAXL ] of integer;

procedure writeL( var a: TLong );

	var i: integer;
		s: string;

	begin
		i := a[0];
		if ( i = 0 ) then begin
			write( '0' ); exit;
		end;
		write( a[i] );
		while ( i > 1 ) do begin
			dec( i );
			s := intToStr( a[i] );
			while ( length( s ) < LOG_BASE ) do s := '0' + s;
			write( s );
		end;
	end;

procedure writelnL( var a: TLong );
	
	begin
		writeL( a ); writeln;
	end;

function extendedValue( var a: TLong ): extended;

	var r: extended;
		i: integer;

	begin
		if ( a[0] = 0 ) then begin
			extendedValue := 0; exit;
		end;
		r := a[a[0]];
		for i := a[0] - 1 downto 1 do r := r * BASE + a[i];
		extendedValue := r;
	end;

procedure assignL( var a, b: TLong );

	begin
		a := b;
	end;

procedure assignL( var a: TLong; b: integer );

	begin
		fillChar( a, sizeOf( a ), 0 );
		a[1] := b;
		while ( a[1] >= BASE ) do begin
			dec( a[1], BASE );
			inc( a[2] );
		end;
		assert( a[2] < BASE );
		a[0] := 2;
		while ( a[0] > 0 ) and ( a[a[0]] = 0 ) do dec( a[0] );
	end;

procedure incL( var a, b: TLong );

	var i, cy: integer;

	begin
		cy := 0;
		a[0] := max( a[0], b[0] );
		for i := 1 to a[0] do begin
			inc( a[i], b[i] + cy );
			if ( a[i] >= BASE ) then begin
				a[i] -= BASE;
				cy := 1;
			end else cy := 0;
		end;
		if ( cy <> 0 ) then begin
			inc( a[0] );
			a[a[0]] := cy;
		end;
	end;

procedure mulL( var a, b, c: TLong );

	var i, j, cy, t, u: integer;

	begin
		fillChar( c, sizeOf( c ), 0 );
		if ( a[0] = 0 ) or ( b[0] = 0 ) then exit;
		c[0] := a[0] + b[0] - 1;
		assert( c[0] <= MAXL, 'TLong overflow' );
		cy := 0;
		for i := 1 to c[0] do begin
			u := min( a[0], i );
			for j := max( 1, i + 1 - b[0] ) to u do inc( cy, a[j] * b[i - j + 1] );
			t := cy div BASE;
			c[i] := cy - t * BASE;
			cy := t;
		end;
		while ( cy > 0 ) do begin
			inc( c[0] );
			t := cy div BASE;
			c[c[0]] := cy - t * BASE;
			cy := t;
		end;
	end;

function isZero( var a: TLong ): boolean;

	begin
		isZero := a[0] = 0;
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
			if ( i >= t ) then
				for j := 1 to n do incL( r[d and 1][j], a[j] );	
		end;
		incL( res, r[d and 1][n] );
		z := true;
		for i := 1 to n do z := z and isZero( r[d and 1][i] );
		inc( d );
	end;
	writelnL( res );
end.
