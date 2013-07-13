uses SysUtils;
type integer = longint;
function revi(k:integer):integer;
var s,s2:string;
	i:integer;
begin
	s := IntToStr(k);
	s2:= '';
	for i:=1 to length(s) do begin
		s2 := s[i]+s2;
	end;
	revi:=StrToInt(s2);
end;
function isr(s:string):boolean;
var tmp:string;
	i,p,pr,r:integer;
begin
        isr:=false;
        for i:=1 to length(s) do
                if ((s[i]<'0') or (s[i]>'9')) then exit;
    if (length(s) = 0) then begin
        isr := true;
        exit;
    end;
    if (length(s) = 1) then begin
    if ( ((ord(s[1])-ord('0')) mod 2) =1) then begin
			isr := false;
		end
		else begin
			isr := true;
		end;
		exit;
	end;
	if (s[1] = s[length(s)]) then begin
		isr := isr(copy(s,2,length(s)-2));
	end
	else if(s[1] > s[length(s)]) then begin
		tmp := copy(s,2,length(s)-2);
		p := length(tmp);
    while ((p>0) and (tmp[p]='0')) do begin
			tmp[p] := '9';
	    dec(p);
		end;
		if (p>0) then tmp[p] := chr(ord(tmp[p])-1)
                else begin
                        isr := false;
                        exit;
                end;
		isr := isr(tmp);
	end
	else begin
		tmp := copy(s,2,length(s)-1);
                pr := (ord(s[1])-ord('0'))*10+ord(s[2])-ord('0');
    isr := false;

		for i:=9 downto 1 do begin
			tmp[1] := chr(ord('0')+pr-i);
			p := length(tmp);
			if (tmp[p]='0') then begin
				tmp[p] := chr(ord('0')+10-i);
				dec(p);
		    while ((p>0) and (tmp[p]='0')) do begin
					tmp[p] := '9';
			    dec(p);
				end;
				if (p>0) then tmp[p] := chr(ord(tmp[p])-1)
			end
			else begin
			  if (tmp[p]>=chr(i+ord('0'))) then begin
					tmp[p] := chr(ord(tmp[p])-i);
			  end
			  else begin
					tmp[p] := chr(ord(tmp[p])+10-i);
					dec(p);
			    while ((p>0) and (tmp[p]='0')) do begin
						tmp[p] := '9';
				    dec(p);
					end;
					if (p>0) then tmp[p] := chr(ord(tmp[p])-1)
			 	end;
			end;
		  if (isr(tmp)) then begin
                  		isr:=true;
				break;
		  end;

	  end;
	end;
end;
var it,l,n,i,k,t:integer;
	yes:boolean;
	s:string;
begin
	assign(input,'reverse.in');
	reset(input);
	assign(output,'reverse.out');
	rewrite(output);
	while (true) do begin
  	readln(s);
  	if (s='0') then break;
  	if (isr(s)) then begin
	  	writeln('YES');
	  end
	  else begin
	    writeln('NO');
	  end;
  end;

  close(input);
	close(output);
end.
