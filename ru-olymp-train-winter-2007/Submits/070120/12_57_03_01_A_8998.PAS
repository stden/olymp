{-$DEFINE V}
{$UNDEF V}
{$MODE DELPHI}
uses SysUtils;
type integer = longint;
	mystring = shortstring;
const MAXBLEN = 100;
	MAXK = 200;
{const MAXBLEN = 100000;
	MAXK = 2000;}
function max(a,b:int64):int64;
begin
	if (a>b) then result:=a
	else result:=b;
end;

var
	b:array[0..MAXBLEN,'a'..'z'] of integer;
	h:array[0..MAXBLEN] of integer;
	s:array[1..MAXK] of mystring;
	c:array[1..MAXK] of integer;
	p,pi,pj:array[1..MAXK,1..MAXK] of integer;
	d:array[0..100,0..MAXK] of int64;
	isEnd:array[0..MAXBLEN] of boolean;
	blen:integer;

procedure qsort(left,right:integer);
var m,tmp:mystring;
	k,i,j,tmpi:integer;
begin

 	i:=left;
	j:=right;
	m := s[(i+j) div 2];
	repeat
		while ((s[i]<m) ) do inc(i);
		while ((s[j]>m)) do dec(j);
		if (i<=j) then begin
			tmp := s[i];
			s[i] := s[j];
			s[j] := tmp;
			tmpi := c[i];
			c[i] := c[j];
			c[j] := tmpi;
      inc(i);
      dec(j);
		end;
	until i>=j;
	if (j>left) then qsort(left,j);
	if (i<right) then qsort(i,right);
end;

procedure add(s:mystring);
var i,pos,count:integer;
begin
	pos := 0;
	count:=0;
	for i:=1 to length(s) do begin
		if (b[pos][s[i]]<0) then begin
			inc(blen);
			b[pos][s[i]] := blen;
		end;
		pos := b[pos][s[i]];
		inc(count);
		h[pos] := count;
	end;
	isend[pos] := true;
end;

procedure makesuf(s:mystring);
begin
	repeat
		add(s);
		delete(s,1,1);
	until length(s)=0;
end;

function getH(s:mystring):integer;
var pos,i:integer;
begin
	pos := 0;
	result:= 0;
	for i:=1 to length(s) do begin
{		if (isend[pos]) then begin
			result:=max(result,h[pos]);
		end;}
		if (b[pos][s[i]]<0) then begin
			break;
		end;
		pos := b[pos][s[i]];
	end;
	if (isend[pos]) then begin
		result:=max(result,h[pos]);
	end;
end;
var
	n,k,i,j,q,ansi,ansj:integer;
	ans:int64;
	tmp,ss:mystring;
begin
	assign(input,'beauty.in');
	reset(input);
assign(output,'beauty.out');
 rewrite(output);
  readln(k);
  for i:=1 to k do begin
    readln(tmp);
    s[i] := copy(tmp,1,pos(' ',tmp)-1);
    delete(tmp,1,pos(' ',tmp));
    c[i] := StrToInt(tmp);
  end;
  qsort(1,k);
  {$IFDEF V} writeln(erroutput,'qsort ok');{$ENDIF}
  read(n);
	close(input);

  for i:=1 to k do begin
  	fillchar(b,sizeof(b),255);
  	fillchar(h,sizeof(h),0);
  	fillchar(isend,sizeof(isend),0);
  	blen:=0;
		makesuf(s[i]);
		for j:=1 to k do begin
			if (j=i) then begin
				tmp := s[j];
				delete(tmp,length(tmp),1);
				p[i][j] := geth(tmp);
			end
			else begin
				p[i][j] := geth(s[j]);
			end;
		end;
  end;
  {$IFDEF V} writeln(erroutput,'p ok');{$ENDIF}
  fillchar(d,sizeof(d),254);

  for i:=0 to n do d[i][0] := 0;

	for i:=0 to n do begin
		for j:=1 to k do begin
			for q:=1 to k do begin
        if (i+length(s[q])-p[j][q]<=n) then begin
					{d[i+length(s[q])-p[j][q]][q] :=
						max(d[i+length(s[q])-p[j][q]][q],d[i][j] + c[q]);}
					if (d[i][j] + c[q] > d[i+length(s[q])-p[j][q]][q]) then begin
						d[i+length(s[q])-p[j][q]][q] := d[i][j] + c[q];
						pi[i+length(s[q])-p[j][q]][q] := i;
						pj[i+length(s[q])-p[j][q]][q] := j;
					end else
          if ((d[i][j] + c[q] = d[i+length(s[q])-p[j][q]][q]) and
            (q <= pj[i+length(s[q])-p[j][q]][q])) then begin
						d[i+length(s[q])-p[j][q]][q] := d[i][j] + c[q];
						pi[i+length(s[q])-p[j][q]][q] := i;
						pj[i+length(s[q])-p[j][q]][q] := j;
					end;
				end;
			end;
		end;
		for q:=1 to k do begin
			if (i+length(s[q])<=n) then begin
		 		{d[i+length(s[q])][q] :=
		 		  max(d[i+length(s[q])][q],d[i][0] + c[q]);}
		 		if (d[i][0] + c[q] > d[i+length(s[q])][q]) then begin
		 		  d[i+length(s[q])][q] := d[i][0] + c[q];
		 		  pi[i+length(s[q])][q] := i;
 		 		  pj[i+length(s[q])][q] := 0;
		 		end else
		 		if ((d[i][0] + c[q] = d[i+length(s[q])][q])
          and(q < pj[i+length(s[q])][q])) then begin
		 		  d[i+length(s[q])][q] := d[i][0] + c[q];
		 		  pi[i+length(s[q])][q] := i;
 		 		  pj[i+length(s[q])][q] := 0;
		 		end;
		 	end;
		end;
	end;
  {$IFDEF V} writeln(erroutput,'d ok');{$ENDIF}
	ans := 0;
	for i:=1 to n do begin
    for j:=0 to k do begin
			if (d[i][j]>ans) then  begin
				ans := d[i][j];
				ansi := i;
				ansj := j;
			end;
		end;
	end;
	writeln(ans);
	i:=ansi;
	j:=ansj;
	ss:='';
  while ((j>0) and (i>0)) do begin
  	ss:=copy(s[j],length(s[j])-(i-pi[i][j])+1,length(s[j]))+ss;
  	ansi := pi[i][j];
  	ansj := pj[i][j];
		i:=ansi;
		j:=ansj;
  end;
  for i:=length(ss)+1 to n do begin
		ss := 'a'+ss;
  end;
  writeln(ss);
	close(output);
end.
