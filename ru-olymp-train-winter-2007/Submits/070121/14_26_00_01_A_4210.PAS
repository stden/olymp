{$MODE DELPHI}
var
	p:array[1..12] of string[2];
procedure qsort(left,right:integer);
var m,tmp:string[2];
	k,i,j:integer;
begin
 	i:=left;
	j:=right;
	m := p[(i+j) div 2];
	repeat
		while (p[i]<m) do inc(i);
		while (p[j]>m) do dec(j);
		if (i<=j) then begin
			tmp := p[i];
			p[i] := p[j];
			p[j] := tmp;
		end;
	until i>=j;
	if (j>left) then qsort(left,j);
	if (i<right) then qsort(i,right);
end;
function getn(c:char):integer;
begin
	case c of
	'A' : begin result := 14; exit; end;
	'K' : begin result := 13; exit; end;
	'Q' : begin result := 12; exit; end;
	'J' : begin result := 11; exit; end;
	'T' : begin result := 10; exit; end;
	end;
	result := ord(c)-ord('0');
end;

function less(c1,c2:char):boolean;
begin
	result:= getn(c1)<getn(c2);
end;

function prev(c:char):char;
begin
	case c of
	'A' : begin result := 'K'; exit; end;
	'K' : begin result := 'Q'; exit; end;
	'Q' : begin result := 'J'; exit; end;
	'J' : begin result := 'T'; exit; end;
	'T' : begin result := '9'; exit; end;
	end;
	result := chr(ord(c)-1);
end;
var
	ch,first,i,j:integer;
	c,c1,c2:char;
	co:array['A'..'Z'] of char;
	ans:integer;
	best:char;
	s:string[2];
  a:array[1..2] of string[2];
begin
	assign(input,'preference.in');
	reset(input);
	assign(output,'preference.out');
	rewrite(output);
	readln(first);
  for i:=1 to 12 do begin
		read(c1,c2,c);
    p[i]:=c1+c2;
  end;
  for i:=1 to 12 do
    for j:=i+1 to 12 do
      if (p[i][2]>p[j][2])or((p[i][2]=p[j][2])and(less(p[j][1],p[i][1]))) then begin
        s:=p[i];
        p[i]:=p[j];
        p[j]:=s;
      end;
  fillchar(co,sizeof(co),0);
  for i:=1 to 12 do begin
//p[i] := p[i+2];
		inc(co[p[i][2]]);
  end;
  best := 'A';
  for c:='B' to 'Z' do begin
		if (co[c]>co[best]) then best := c;
  end;
  ch := 0;
  for i:=1 to 10 do begin
    if ((p[i][2]<>best) and (ch<2)) then begin
      inc(ch);
      a[ch] := p[i];
    end;
    p[i] := p[i+ch];
  end;
  ans:=0;
  if (p[10][2] = best) or (p[10][1] = 'A') then inc(ans);
  for i:=9 downto 1 do begin
		if (p[i][2] = best) or (p[i][1] = 'A') or ((p[i][2] = p[i+1][2]) and(p[i][1] = prev(p[i+1][1]))) then inc(ans);
  end;
  if (first<>1) then dec(ans);
  writeln(ans);
  writeln(a[1], ' ',a[2]);
  writeln(best);

	close(input);
	close(output);
end.
