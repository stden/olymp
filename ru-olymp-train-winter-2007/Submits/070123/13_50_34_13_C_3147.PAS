{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
uses Math,SysUtils;
const maxn = 370;
var f: array[1..maxn,1..maxn,1..maxn] of boolean;
    g: array[0..maxn,0..maxn] of boolean;
    n,k,v,u,c,i,j,b,num,cur: longint;
    found,sum: boolean;
    s: ansistring;
    ch: char;

procedure swap(var a,b: char);
var t: char;
begin
	t := a; a := b; b := t;
end;

function reverse(const s: ansistring): ansistring;
var i: longint;
begin
	result := s;
	for i:=1 to length(s) div 2 do
		swap(result[i],result[length(s)-i+1]);
end;

function RIntToBin(n,base: longint): ansistring;
begin
	result := '';
	while (n <> 0) do
	begin
		if (n mod 2 = 0) then
			result := result + '0' else
			result := result + '1';
		n := n shr 1;
	end;
	while (length(result)<base) do result := result + '0';
end;

begin
	fillchar(g,sizeof(g),false);
	assign(input,'tourism.in'); reset(input);
	readln(n);
	while not seekeoln do
	begin
		read(ch);
		num := 0;
		case ch of
			'0'..'9': num := Byte(ch)-48;
			'A'..'Z': num := Byte(ch)-64+10;
			'a'..'z': num := Byte(ch)-96+36;
			'!':      num := 62;
			'?':      num := 63;
		end;
		s := s+RIntToBin(num,6);
	end;
	i := 1; v := 0;
	while (v < n) do
	begin
		for j:=v+1 to n-1 do
			if (s[i+j-v-1]='1') then
				g[v+1,j+1] := true else
				g[j+1,v+1] := true;
		inc(i,n-v-1);
		inc(v);
   end;
	fillchar(f,sizeof(f),false);
	for i:=1 to n do
		for j:=1 to n do
			 f[i,j,2] := g[i,j];
	for c:=3 to n+1 do
		for i:=1 to n do
			for j:=1 to n do
			begin
				sum := false;
				for v:=1 to n do
					if (g[i,v]) then
					begin
						sum := sum or f[v,j,c-1];
						if sum then break;
					end;
				f[i,j,c] := sum;
			end;
	assign(output,'tourism.out'); rewrite(output);
	read(k);
	for i:=1 to k do
	begin
		read(b);
		found := false;
		if (b > 2) and (b <= n) then
      begin
         inc(b);
			for j:=1 to n do
				if (f[j,j,b]) then
				begin
					v := j; cur := b;
					while (cur > 2) do
					begin
						write(v-1,' ');
						for u:=1 to n do
							if (g[v,u] and f[u,j,cur-1]) then
							begin
								v := u; dec(cur);
								break;
							end;
					end;
               writeln(v-1,' ');
					found := true;
					break;
				end;
      end;
		if not found then writeln(-1);
	end;
	close(output);
	close(input);
end.
