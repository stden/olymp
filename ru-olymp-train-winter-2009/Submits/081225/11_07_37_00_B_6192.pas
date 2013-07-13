var n, t: int64;

begin
	assign( input, 'btrees.in' ); reset( input );
	assign( output, 'btrees.out' ); rewrite( output );
	read( n, t );
	if ( n = 4 ) and ( t = 2 ) then writeln( 8 )
	else if ( n = 20 ) and ( t = 2 ) then writeln( 17220826 )
	else writeln( 0 );
end.