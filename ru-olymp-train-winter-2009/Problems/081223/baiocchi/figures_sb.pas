{$H+,Q+,R+}

unit figures_sb;

interface

uses SysUtils;

const
	MAXN = 8;
	MAXS = 20;
	dx: array[ 1 .. 4 ] of integer = ( 0, 1, 0, -1 );
	dy: array[ 1 .. 4 ] of integer = ( 1, 0, -1, 0 );

type TFigure = array[ -MAXS .. MAXS, -MAXS .. MAXS ] of integer;

type TList = record
	s: integer;
	x: array[ 1 .. MAXN ] of integer;
	y: array[ 1 .. MAXN ] of integer;
end;

function toString( var f: TFigure ): string;

procedure print( var s: string );

function put( var f: TFigure; l: TList; c: integer ): boolean;

function isIobacci( var f: TFigure ): boolean;

function readFigure: TList;

procedure shift( var l: TList; x, y: integer );

function reflectX( l: TList ): TList;

function reflectY( l: TList ): TList;

function rotate( l: TList ): TList;

function reflectXt( l: TList ): TList;

function reflectYt( l: TList ): TList;

function rotatet( l: TList ): TList;

implementation

uses Math;

const NEW_LINE_CH = '_';

procedure getRange( var f: TFigure; var minX, maxX, minY, maxY: integer );

	var i, j: integer;

	begin
		minX := MAXS;
		maxX := -MAXS;
		minY := MAXS;
		maxY := -MAXS;
		for i := -MAXS to MAXS do for j := -MAXS to MAXS do if ( f[i][j] > 0 ) then begin
			minX := min( minX, i );
			maxX := max( maxX, i );
			minY := min( minY, j );
			maxY := max( maxY, j );
		end;
	end;

function toString( var f: TFigure ): string;

	procedure rotate( var f: TFigure );

		var i, j, t: integer;

		begin
			for i := 1 to MAXS do
				for j := 0 to MAXS do begin
					t := f[i][j];
					f[i][j] := f[j][-i];
					f[j][-i] := f[-i][-j];
					f[-i][-j] := f[-j][i];
					f[-j][i] := t;
				end;
		end;

	procedure reflectX( var f: TFigure );

		var i, j, t: integer;

		begin
			for i := 1 to MAXS do
				for j := -MAXS to MAXS do begin
					t := f[i][j];
					f[i][j] := f[-i][j];
					f[-i][j] := t;
				end;
		end;

	function getString( var f: TFigure ): string;

		var minX, maxX, minY, maxY, i, j: integer;
			s: string;

		begin
			getRange( f, minX, maxX, minY, maxY );
			s := '';
			for i := minX to maxX do begin
				for j := minY to maxY do
					if ( f[i][j] = 0 ) then s := s + '.'
					else s := s + char( ord( 'A' ) + f[i][j] - 1 );
				s := s + NEW_LINE_CH;
			end;
			getString := s;
		end;

	var ref, rot: integer;
		s, t: string;

	begin
		s := '';
		for ref := 1 to 2 do begin
			for rot := 1 to 4 do begin
				t := getString( f );
				if ( s = '' ) or ( t < s ) then s := t;
				rotate( f );
			end;
			reflectX( f );
		end;
		toString := s;
	end;

procedure print( var s: string );

	var i: integer;

	begin
		for i := 1 to length( s ) do
			if ( s[i] = NEW_LINE_CH ) then writeln
			else write( s[i] );
		writeln;
	end;

function put( var f: TFigure; l: TList; c: integer ): boolean;

	var i: integer;

	begin
		put := true;
		for i := 1 to l.s do begin
			if ( f[l.x[i]][l.y[i]] > 0 ) then put := false;
			f[l.x[i]][l.y[i]] := c;
		end;
	end;

function isIobacci( var f: TFigure ): boolean;

	var g: array[ -MAXS .. MAXS, -MAXS .. MAXS ] of boolean;

	procedure go( x, y: integer );

		var i: integer;

		begin
			if ( x < -MAXS ) or ( x > MAXS ) or ( y < -MAXS ) or ( y > MAXS ) then exit;
			if ( g[x][y] or ( f[x][y] = 0 ) ) then exit;
			g[x][y] := true;
			for i := 1 to 4 do go( x + dx[i], y + dy[i] );
		end;

	var i, j, minX, maxX, minY, maxY: integer;
		ok, ff: boolean;

	begin
		isIobacci := true;
		fillChar( g, sizeOf( g ), 0 );
		ok := false;
		for i := -MAXS to MAXS do begin
			for j := -MAXS to MAXS do if ( f[i][j] > 0 ) then begin
				go( i, j );
				ok := true;
				break;
			end;
			if ( ok ) then break;
		end;
		for i := -MAXS to MAXS do
			for j := -MAXS to MAXS do
				if ( f[i][j] > 0 ) and ( not g[i][j] ) then ok := false;
		if ( not ok ) then begin
			isIobacci := false;
			exit;
		end;
		getRange( f, minX, maxX, minY, maxY );
		if ( ( minX + maxX + minY + maxY ) mod 2 <> 0 ) then begin
			isIobacci := false;
			exit;
		end;
		for i := minX to maxX do for j := minY to maxY do begin
			ff := f[i][j] > 0;
			if ( ff <> ( f[minX + maxX - i][j] > 0 ) ) or
					( ff <> ( f[minX + maxX - i][minY + maxY - j] > 0 ) ) or
					( ff <> ( f[i][minY + maxY - j] > 0 ) ) or
					( ff <> ( f[( minX + maxX + minY + maxY ) div 2 - j][( -minX - maxX + minY + maxY ) div 2 + i] > 0 ) ) or
					( ff <> ( f[( minX + maxX - minY - maxY ) div 2 + j][( -minX - maxX + minY + maxY ) div 2 + i] > 0 ) ) or
					( ff <> ( f[( minX + maxX - minY - maxY ) div 2 + j][( minX + maxX + minY + maxY ) div 2 - i] > 0 ) ) or
					( ff <> ( f[( minX + maxX + minY + maxY ) div 2 - j][( minX + maxX + minY + maxY ) div 2 - i] > 0 ) ) then begin
				isIobacci := false;
				exit;
			end;
		end;
	end;

function readFigure: TList;

	var l: TList;
		i, j: integer;
		s: string;

	begin
		l.s := 0;
		i := 0;
		repeat
			readln( s );
			for j := 1 to length( s ) do if ( s[j] <> '.' ) then begin
				inc( l.s );
				l.x[l.s] := i;
				l.y[l.s] := j - 1;
			end;
			inc( i );
		until ( s = '' );
		readFigure := l;
	end;

procedure shift( var l: TList; x, y: integer );

	var i: integer;

	begin
		for i := 1 to l.s do begin
			inc( l.x[i], x );
			inc( l.y[i], y );
		end;
	end;

function reflectX( l: TList ): TList;

	var m: TList;
		i: integer;

	begin
		m.s := l.s;
		for i := 1 to l.s do begin
			m.x[i] := l.x[i];
			m.y[i] := -l.y[i];
		end;
		reflectX := m;
	end;

function reflectY( l: TList ): TList;

	var m: TList;
		i: integer;

	begin
		m.s := l.s;
		for i := 1 to l.s do begin
			m.x[i] := -l.x[i];
			m.y[i] := l.y[i];
		end;
		reflectY := m;
	end;

function rotate( l: TList ): TList;

	var m: TList;
		i: integer;

	begin
		m.s := l.s;
		for i := 1 to l.s do begin
			m.y[i] := -l.x[i];
			m.x[i] := l.y[i];
		end;
		rotate := m;
	end;

function reflectXt( l: TList ): TList;

	var m: TList;
		i: integer;

	begin
		m.s := l.s;
		for i := 1 to l.s do begin
			m.x[i] := l.x[i];
			m.y[i] := -l.y[i] - 1;
		end;
		reflectXt := m;
	end;

function reflectYt( l: TList ): TList;

	var m: TList;
		i: integer;

	begin
		m.s := l.s;
		for i := 1 to l.s do begin
			m.x[i] := -l.x[i] - 1;
			m.y[i] := l.y[i];
		end;
		reflectYt := m;
	end;

function rotatet( l: TList ): TList;

	var m: TList;
		i: integer;

	begin
		m.s := l.s;
		for i := 1 to l.s do begin
			m.x[i] := l.y[i];
			m.y[i] := -l.x[i] - 1;
		end;
		rotatet := m;
	end;

end.
