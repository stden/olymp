{$Q-;R-;S-;I-;O+}
{$mode delphi}
uses binsearch;
var l,r,t,n: longint;
    needCheck,ans: boolean;

function safe_query(i: longint): boolean;
var a,b: boolean;
begin
	a := query(i);
	if needCheck then b := query(i) else b := a;
	if (a = b) then
		result := a else
		begin
			result := query(i);
			needCheck := false;
		end;
end;

begin
	n := getN();
	l := 1; r := n+1;
	needCheck := true;
	while (l < r) do
	begin
		t := (l+r) shr 1;
		ans := safe_query(t);
		if ans then r := t else
			l := t+1;
	end;
	answer(r);
end.