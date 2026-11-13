{$H+}

uses figures_sb;

type integer = longint;

const
	MAXP = 600;

var f: TFigure;
	w: array[ 1 .. MAXP ] of string;
	ready: integer;

procedure build( left: integer );

	var i, j, k: integer;
		ok: boolean;
		s: string;

	begin
		if ( left > 0 ) then begin
			for i := -MAXN to MAXN do
				for j := 0 to MAXN do begin
					if ( f[i][j] > 0 ) then continue;
					ok := false;
					for k := 1 to 4 do begin
						if ( i + dx[k] < -MAXN ) or ( i + dx[k] > MAXN ) or
								( j + dy[k] < 0 ) or ( j + dy[k] > MAXN ) then continue;
						ok := ok or ( f[i + dx[k]][j + dy[k]] > 0 );
					end;
					if ( ok ) then begin
						f[i][j] := 1;
						build( left - 1 );
						f[i][j] := 0;
					end;
				end;
		end else begin
			s := toString( f );
			ok := true;
			for i := 1 to ready do if ( s = w[i] ) then ok := false;
			if ( not ok ) then exit;
			inc( ready );
			w[ready] := s;
			print( s );
		end;
	end;

var n, c: integer;

begin
	ready := 0;
	fillChar( f, sizeOf( f ), 0 );
	f[0][0] := 1;
	val( paramStr( 1 ), n, c );
	build( n - 1 );
	writeln( erroutput, ready );
end.
