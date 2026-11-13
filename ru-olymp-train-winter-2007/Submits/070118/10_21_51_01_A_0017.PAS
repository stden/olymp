{$MODE DELPHI}
{$M 64000000}
type integer = longint;
const
	P2_15m1 = 32767;
	EPS = 1e-7;
var
	c:array[0..P2_15m1,1..15] of double;
	a:array[1..15,1..15] of integer;
	b:array[1..15,1..15] of double;
	n:integer;
function fortun(mask,player:integer;lk:double):double;
var tmp:array[1..15] of boolean;
	i,j,ansc,m:integer;
	kill,s:double;
begin
  if (lk<EPS) then begin
		result := 0;
		exit;
  end;
{  if random(1000)=-1 then begin m:=mask;
  for i:=1 to n do begin
     write(erroutput,m mod 2);
     m:= m div 2;
  end;
  writeln(erroutput,' - ',lk);
  end;}
	if (c[mask][player] > 0) then begin
		result:=c[mask][player];
		exit;
	end;
	ansc := 0;
	s:=0;
	m:=mask;

	for i:=1 to n do begin
		if (m and 1 = 1) then begin
			tmp[i]:=true;
			if (i<>player) then s := s+ a[player][i];
			inc(ansc);
		end
		else tmp[i]:=false;
		m := m shr 1;
	end;
	if (ansc=1) then begin
		c[mask][player] := 0;
		result := 0;
		exit;
	end;
	if (not tmp[player]) then begin
		c[mask][player] := fortun(mask,player mod n +1,lk);
		result := c[mask][player];
		exit;
	end;
	result := 0.0;
	ansc := 0;
        kill:=0.0;
	for i:=1 to n do begin
	  if ((i<>player) and (tmp[i])) then begin
			inc(ansc);
			result := result + (a[player][i]/s)*b[player][i]*(fortun(mask xor (1 shl (i-1)),player mod n +1,lk)+1);
                        kill := kill + (a[player][i]/s)*b[player][i];
		end;
	end;
//  writeln(erroutput,kill,' ',result);
  if (1-kill > EPS) then result := result + (1-kill)*(fortun(mask,player mod n +1,lk*(1-kill))+1);
//  writeln(erroutput,'=',result);
  result := result / ansc;
	c[mask][player]	:= result;
end;
var i,j:integer;
begin
	assign(input,'game.in');
	reset(input);
	assign(output,'game.out');
	rewrite(output);
	read(n);
	for i:=1 to n do begin
		for j:=1 to n do begin
			read(a[i][j]);
		end;
	end;
	for i:=1 to n do begin
		for j:=1 to n do begin
			read(b[i][j]);
		end;
	end;
  //writeln(erroutput,(1 shl n) -1);
	writeln(fortun((1 shl n) -1,1,1.0):0:10);
	close(input);
	close(output);
end.
