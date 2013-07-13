uses
	testlib, sysutils;

var
	n, pa, ja: longint;
	comment: string;

begin
	n := inf.readlongint;
	pa := ouf.readlongint;
	ja := ans.readlongint;

	if (pa = -1) then begin
		ouf.seekeof;
		comment := ouf.readstring;
		quit(_Wa, comment);
	end;

	if pa > ja then
		quit(_wa, format('not optimal, expected: %d, found: %d', [ja, pa]));
	if pa < ja then
		quit(_wa, format('incorrect, too few queries, expected: %d, found: %d', [ja, pa]));

	quit(_ok, format('%d queries', [ja]));
end.