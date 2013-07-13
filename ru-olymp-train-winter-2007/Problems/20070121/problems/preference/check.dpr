uses
	testlib, sysutils;
var
	pc, jc, vars, i: longint;
	ja: array [1..10000, 1..3] of string;
	pa: array [1..3] of string;
	t: string;
	found: boolean;
begin
	pc := ouf.readlongint;
	jc := ans.readlongint;

	if pc <> jc then
		quit(_wa, format('wrong count - expected: %d, found: %d', [jc, pc]));

	vars := ans.readlongint;
	for i := 1 to vars do begin
		ja[i][1] := ans.readword(blanks, blanks);
		ja[i][2] := ans.readword(blanks, blanks);
		ja[i][3] := ans.readword(blanks, blanks);
		if ja[i][1] > ja[i][2] then begin
			t := ja[i][1]; ja[i][1] := ja[i][2]; ja[i][2] := t;
		end;
	end;

	pa[1] := ouf.readword(blanks, blanks);
	pa[2] := ouf.readword(blanks, blanks);
	pa[3] := ouf.readword(blanks, blanks);
	if pa[1] > pa[2] then begin
		t := pa[1]; pa[1] := pa[2]; pa[2] := t;
	end;

	found := false;
	for i := 1 to vars do begin
		if (pa[1] = ja[i][1]) and (pa[2] = ja[i][2]) and (pa[3] = ja[i][3]) then begin
			found := true;
			break;
		end;
	end;

	if found then
		quit(_ok, format('%d', [pc]));

	quit(_wa, 'wrong cards and/or suit');
end.                                          