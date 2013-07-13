{$MODE DELPHI}
{$R-,Q-,S-,I-}
const
  MAXN = 300000;
	UP_ = -1;
	DOWN_ = 1;
	LEFT = -1;
	RIGHT = 1;
  EPS = 1e-9;
type
	integer = longint;
	Vertex = record
		x,y,p:integer;
	end;
	line = record
		a,b,c:extended;
	end;
var
	dvc,uvc:integer;
  up,down:array[1..MAXN] of Vertex;
  upo,downo:array[1..MAXN] of Vertex;
procedure swap(var p1,p2:vertex);
var tmp:vertex;
begin
  tmp := p1;
  p1 := p2;
  p2 := tmp;
end;

function getline(p1,p2:vertex):line;
begin
	result.a := p1.y-p2.y;
	result.b := p2.x-p1.x;
	result.c := p1.x*(p2.y-p1.y)+p1.y*(p1.x-p2.x);
end;
function val(l:line;p:vertex):extended;
begin
	result:= l.a*p.x+l.b*p.y+l.c;
end;
function cross(p11,p12,p21,p22:vertex):boolean;
var l:line;
begin
	result:=false;
	l:= getline(p11,p12);
	if (val(l,p21)*val(l,p22)>=0) then exit;
	l:= getline(p21,p22);
	if (val(l,p11)*val(l,p12)>=0) then exit;
	result:= true;
end;
function can(p1,p2:vertex):boolean;
var i:integer;
begin
	result := false;
	for i:=1 to uvc-1 do begin
	  if (cross(p1,p2,upo[i],upo[i+1])) then begin
			exit;
	  end;
	end;
	for i:=1 to dvc-1 do begin
	  if (cross(p1,p2,downo[i],downo[i+1])) then begin
	  	exit;
	  end;
	end;
	result := true;
end;

var
  x,y,p,u:array[1..MAXN] of integer;

procedure qsort(left,right:integer);
var m,tmp,my:integer;
	k,i,j:integer;
begin
 	i:=left;
	j:=right;
	m := x[(i+j) div 2];
	my := y[(i+j) div 2];
	repeat
		while ((x[i]<m) or ((x[i]=m)and (y[i]>my))) do inc(i);
		while (x[j]>m) do dec(j);
		if (i<=j) then begin
			tmp := x[i];
			x[i] := x[j];
			x[j] := tmp; 			
			tmp := y[i];
			y[i] := y[j];
			y[j] := tmp;
			tmp := p[i];
			p[i] := p[j];
			p[j] := tmp;
			tmp := u[i];
			u[i] := u[j];
			u[j] := tmp;
      inc(i);
      dec(j);
		end;
	until i>=j;
	if (j>left) then qsort(left,j);
	if (i<right) then qsort(i,right);
end;

var
	dir,n,i,j,di,ui:integer;
	ok:boolean;
	tg1:extended;
	p1,p2:vertex;
begin
	assign(input,'tri.in');
	reset(input);
	assign(output,'tri.out');
	rewrite(output);
  read(n);
  read(x[1],y[1]);
  p[1] := 1;
  read(x[2],y[2]);
  p[2] := 2;
  if (x[2]>x[1]) then begin
		dir := RIGHT;
		u[1] := DOWN_;
		u[2] := DOWN_;
  end
  else begin
		dir := LEFT;
		u[1] := UP_;
		u[2] := UP_;
  end;
  for i:=3 to n do begin
		read(x[i],y[i]);
		p[i] := i;
		if ((x[i]-x[i-1])*dir>0) then begin
			u[i]:= u[i-1];
		end
		else begin
			dir := -dir;
			u[i] := -u[i-1];
		end;
  end;
  qsort(1,n);
  uvc := 0;
  dvc := 0;
  for i:=1 to n do begin
		if (u[i]=UP_) then begin
			inc(uvc);
			up[uvc].x := x[i];
			up[uvc].y := y[i];
			up[uvc].p := p[i];
		end
		else begin
      inc(dvc);
			down[dvc].x := x[i];
			down[dvc].y := y[i];
			down[dvc].p := p[i];
		end;
  end;
  for i:=1 to uvc do begin
    upo[i] := up[i];
  end;
  for i:=1 to dvc do begin
    downo[i] := down[i];
  end;
  ui:=1;
  di:=1;
//  writeln('------');
  while ((ui<uvc) or (di <dvc)) do begin
//  down[di] -> up[ui+1]
		if (ui<uvc) then begin
			ok := true;
			p1 := down[di];
			p2 := up[ui+1];
			if (can(p1,p2)) then begin
				writeln(down[di].p,' ',up[ui].p,' ',up[ui+1].p);
				inc(ui);
				continue;
			end;
		end;
//	up[ui] -> down[di+1]
		if (di<dvc) then begin
			ok:=true;

			p1 := down[di+1];
			p2 := up[ui];
			if (can(p1,p2)) then begin
				writeln(down[di].p,' ',up[ui].p,' ',down[di+1].p);
				inc(di);
				continue;
			end;
		end;
//  down[di] - > down[di+2]
		if (di<dvc-1) then begin
			ok:=true;

			p1 := down[di+2];
			p2 := down[di];
			if (can(p1,p2)) then begin
				writeln(down[di].p,' ',down[di+1].p,' ',down[di+2].p);
        swap(down[di],down[di+1]);
				inc(di,1);
				continue;
			end;
		end;
//  up[ui] - > up[ui+2]
		if (ui<uvc-1) then begin
			ok:=true;

			p1 := up[ui+2];
			p2 := up[ui];
			if (can(p1,p2)) then begin
				writeln(up[ui].p,' ',up[ui+1].p,' ',up[ui+2].p);
        swap(up[ui],up[ui+1]);
				inc(ui,2);
				continue;
			end;
		end;
		writeln('FAIL');
		break;
  end;

	close(input);
	close(output);
end.
