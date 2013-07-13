{$Q-;R-;S-;I-;O+}
{$mode delphi}
const symbol: set of char = ['!'..'~'];
var pr: array[1..10000] of longint;
    i,j,k: longint;
    s: string;
    ch: char;
begin
	s := '';
	assign(input,'substr.in'); reset(input);
	read(ch);
	while (ch <> '*') do
	begin
		if ch in symbol then s := s+ch;
		read(ch);
	end;
	fillchar(pr,sizeof(pr),0);
	pr[1] := 1; k := 0;
	for i:=2 to length(s) do
	begin
		while (k > 0) and (s[i]<>s[k+1]) do k := pr[k];
		if (s[i]=s[k+1]) then inc(k);
		pr[i] := k;
	end;
	assign(output,'substr.out'); rewrite(output);
	j := 0; k := 0;
	while not eof do
	begin
		read(ch);
		if (ch in symbol) then
		begin
			inc(j);
			while (k > 0) and (ch<>s[k+1]) do k := pr[k];
			if (ch=s[k+1]) then inc(k);
			if (k=length(s)) then
				writeln(j-k+1);
		end;
	end;
	close(output);
	close(input);
end.
