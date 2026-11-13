{$Q-;R-;S-;I-;O+}
{$mode delphi}
var x,y: array[1..4] of longint;
    t,p,xt,yt,xv1,yv1,xv2,yv2: extended;
    i,j: longint;

procedure swap(var a,b: longint);
var t: longint;
begin
	t := a; a := b; b := t;
end;

function vp(x1,y1,x2,y2,x3,y3: longint): longint;
begin
	result := (x2-x1)*(y3-y2)-(x3-x2)*(y2-y1);
	if (result < 0) then
		result := -1 else
			if (result > 0) then result := 1 else result := 0;
end;

procedure quit;
begin
	close(output); halt;
end;

begin
	assign(input,'interseg.in'); reset(input);
	read(x[1],y[1],x[2],y[2],x[3],y[3],x[4],y[4]);
	close(input);
	t := (x[3]-x[1])*(y[3]-y[4])-(x[3]-x[4])*(y[3]-y[1]);
	p := (x[2]-x[1])*(y[3]-y[4])-(x[3]-x[4])*(y[2]-y[1]);
	assign(output,'interseg.out'); rewrite(output);
	if (x[1]=x[2]) and (x[2]=x[3]) and (x[3]=x[4]) and (y[1]=y[2]) and (y[2]=y[3]) and (y[3]=y[4]) then
	begin
		writeln(x[1],' ',y[1]);
		quit;
	end;
	if (p <> 0) then
	begin
		if (vp(x[1],y[1],x[2],y[2],x[3],y[3])=vp(x[1],y[1],x[2],y[2],x[4],y[4])) or
		   (vp(x[3],y[3],x[4],y[4],x[1],y[1])=vp(x[3],y[3],x[4],y[4],x[2],y[2])) then
		   begin
				writeln('Empty');
				quit;
			end;
		t := t/p;
		xt := (x[2]-x[1])*t+x[1];
		yt := (y[2]-y[1])*t+y[1];
	end else
	begin
		xv1 := x[2]-x[1];
		yv1 := y[2]-y[1];
		xv2 := x[4]-x[3];
		yv2 := y[4]-y[3];
		if (xv1 = 0) and (yv1 = 0) and (vp(x[1],y[1],x[3],y[3],x[4],y[4])=0) then
		begin
			if (x[3]<>x[4]) then
				t := (x[1]-x[3])/(x[4]-x[3]) else
				t := (y[1]-y[3])/(y[4]-y[3]);
			if (t>=0) and (t<=1) then
				writeln(extended(x[1]):10:6,extended(y[1]):10:6) else
				writeln('Empty');
			quit;
		end;
		if (xv2 = 0) and (yv2 = 0) and (vp(x[3],y[3],x[1],y[1],x[2],y[2])=0) then
		begin
			if (x[1]<>x[2]) then
				t := (x[3]-x[2])/(x[1]-x[2]) else
				t := (y[1]-y[2])/(y[1]-y[2]);
			if (t>=0) and (t<=1) then
				writeln(extended(x[3]):10:6,extended(y[3]):10:6) else
				writeln('Empty');
			quit;
		end;
		if (xv1*yv2<>yv1*xv2) then
			writeln('Empty') else
			begin
				for i:=1 to 4 do
					for j:=2 to 4 do
					if (x[j]<x[j-1]) or ((x[j]=x[j-1]) and (y[j]<y[j-1])) then
					begin
						swap(x[j],x[j-1]);
						swap(y[j],y[j-1]);
					end;
				writeln(extended(x[2]):10:6,extended(y[2]):10:6,extended(x[3]):10:6,extended(y[3]):10:6);
			end;
		quit;
	end;
	writeln(xt:10:6,' ',yt:10:6);
	close(output);
end.