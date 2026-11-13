{$H+,Q+,R+}

uses SysUtils, Math, figures_sb;

var l, m: TList;
	f: TFigure;
	ok: boolean;
	ref, rot, i, j: integer;
	s: string;

begin
	{writeln( erroutput, l.s );}
	while ( true ) do begin
		l := readFigure;
		if ( l.s = 0 ) then break;
		ok := false;
		for ref := 1 to 2 do begin
			for rot := 1 to 4 do begin
				for i := 0 to MAXN do begin
					for j := 0 to MAXN do begin
						shift( l, i, j );
						fillChar( f, sizeOf( f ), 0 );
						if ( put( f, l, 1 ) and put( f, reflectX( l ), 2 ) and
								put( f, reflectY( l ), 3 ) and put( f, reflectX( reflectY( l ) ), 4 ) ) then begin
							s := toString( f );
							{writeln( erroutput, ref, ' ', rot, ' ', i, ' ', j, ' ', s, ' ', isIobacci( f ) );}
							{writeln( ref, ' ', rot, ' ', i, ' ', j, ' ', s, ' ', isIobacci( f ) );
							flush( output );}
							if ( isIobacci( f ) ) then begin
								ok := true;
								break;
							end;
						end;
						fillChar( f, sizeOf( f ), 0 );
						if ( put( f, l, 1 ) and put( f, rotate( l ), 2 ) and
								put( f, rotate( rotate( l ) ), 3 ) and put( f, rotate( rotate( rotate( l ) ) ), 4 ) ) then begin
							s := toString( f );
							if ( isIobacci( f ) ) then begin
								ok := true;
								break;
							end;
						end;
						fillChar( f, sizeOf( f ), 0 );
						if ( put( f, l, 1 ) and put( f, reflectXt( l ), 2 ) and
								put( f, reflectYt( l ), 3 ) and put( f, reflectXt( reflectYt( l ) ), 4 ) ) then begin
							s := toString( f );
							if ( isIobacci( f ) ) then begin
								ok := true;
								break;
							end;
						end;
						fillChar( f, sizeOf( f ), 0 );
						if ( put( f, l, 1 ) and put( f, rotatet( l ), 2 ) and
								put( f, rotatet( rotatet( l ) ), 3 ) and put( f, rotatet( rotatet( rotatet( l ) ) ), 4 ) ) then begin
							s := toString( f );
							if ( isIobacci( f ) ) then begin
								ok := true;
								break;
							end;
						end;
						shift( l, -i, -j );
					end;
					if ( ok ) then break;
				end;
				l := rotate( l );
				if ( ok ) then break;
			end;
			l := reflectX( l );
			if ( ok ) then break;
		end;
		if ( ok ) then begin
			{s := toString( f );
			writeln( erroutput, s, ' ', isIobacci( f ) );}
			print( s );
			continue;
		end;
		for ref := 1 to 2 do begin
			for rot := 1 to 4 do begin
				{writeln( erroutput, ref, ' ', rot );}
				for i := 0 to MAXN do begin
					for j := 0 to MAXN do begin
						{writeln( ref, ' ', rot, ' ', i, ' ', j );
						flush( output );}
						shift( l, i, j );
						fillChar( f, sizeOf( f ), 0 );
						m := rotate( l );
						if ( put( f, l, 1 ) and put( f, reflectX( l ), 2 ) and
								put( f, reflectY( l ), 3 ) and put( f, reflectX( reflectY( l ) ), 4 ) and
								put( f, m, 5 ) and put( f, reflectX( m ), 6 ) and
								put( f, reflectY( m ), 7 ) and put( f, reflectX( reflectY( m ) ), 8 ) ) then begin
							if ( isIobacci( f ) ) then begin
								ok := true;
								break;
							end;
						end;
						fillChar( f, sizeOf( f ), 0 );
						m := rotatet( l );
						if ( put( f, l, 1 ) and put( f, reflectXt( l ), 2 ) and
								put( f, reflectYt( l ), 3 ) and put( f, reflectXt( reflectYt( l ) ), 4 ) and
								put( f, m, 5 ) and put( f, reflectXt( m ), 6 ) and
								put( f, reflectYt( m ), 7 ) and put( f, reflectXt( reflectYt( m ) ), 8 ) ) then begin
							if ( isIobacci( f ) ) then begin
								ok := true;
								break;
							end;
						end;
						shift( l, -i, -j );
					end;
					if ( ok ) then break;
				end;
				l := rotate( l );
				if ( ok ) then break;
			end;
			l := reflectX( l );
			if ( ok ) then break;
		end;
		if ( ok ) then begin
			s := toString( f );
			print( s );
		end;
	end;
end.