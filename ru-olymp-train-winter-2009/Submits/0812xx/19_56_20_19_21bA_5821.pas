{$H+}



Const inf:Cardinal=2*MaxLongInt+1;
			MaxN=64000;MaxM=100000;
Type  Integer=LongInt;
      TEdge=record
		  v:Integer;
			val:Cardinal;
		 end;

Var use:Array[1..MaxN]of Integer;
		nGroups,tm,tuse:Integer;
		first:Array[1..MaxN]of Integer;
		next:Array[1..MaxM]of integer;
		g:Array[1..MaxM]of TEdge;
		Group:Array[1..MaxN]of String;
		c:Char;
Procedure Sdohnite;
Begin
	while true do;
End;
Function digit(ch:Char):Cardinal;
Begin
	if (ch>='0')and(ch<='9') then digit:=ord(ch)-ord('0');
  if (ch>='a')and(ch<='f') then digit:=10+ord(ch)-ord('a');
  if (ch>='A')and(ch<='F') then digit:=10+ord(ch)-ord('A');
	if not ((ch in ['0'..'9']) or (ch in ['a'..'f']) or (ch in ['A'..'F']) ) then Sdohnite;
End;

Procedure DFS(v,bit,en:Integer);
Var i,tec:Integer;
    t:Cardinal;
Begin
	use[v]:=tuse;if v=en then exit;
	tec:=first[v];
        t:=1 shl bit;
	while tec<>0 do begin
		if ((t and(g[tec].val))<>0)and(use[g[tec].v]<>tuse) then DFS(g[tec].v,bit,en);
		tec:=next[tec];if use[en]=tuse then exit;
	end;
End;

Procedure Add(v1,v2:Integer;key:Cardinal);
Begin
	Inc(tm);g[tm].v:=v2;g[tm].val:=key;
	next[tm]:=first[v1];
	first[v1]:=tm;
End;

Procedure Modify(v1,v2:Integer;ch:Char;mask:Cardinal);
Var tec:Integer;
Begin
	if (v1=1)or(v2=2) then sdohnite;
	tec:=first[v1];
	while tec<>0 do begin
		if g[tec].v=v2 then break;
		tec:=next[tec];
	end;
	if tec=0 then
		if ch='-' then Add(v1,v2,0) else Add(v1,v2,mask);


	if tec<>0 then case ch of
		'=':g[tec].val:=mask;
		'+':g[tec].val:=g[tec].val or mask;
		'-':g[tec].val:=g[tec].val and (not mask);
	end;
End;

Function find(s:String):Integer;
Var i:Integer;
Begin
	for i:=1 to nGroups do if Group[i]=s then begin
		find:=i;exit;
	end;
	Inc(nGroups);Group[nGroups]:=s;find:=nGroups;
	if (s<>'initial')and(s<>'final') then begin
		Add(1,nGroups,inf);Add(nGroups,2,inf);
	end;
End;

Procedure Init;
Var v1:Integer;
Begin
	nGroups:=0;
	v1:=Find('initial');v1:=Find('final');
	Add(1,2,inf);
End;


Procedure SkipTabs;
Begin
	repeat Read(c)
	until c<>#9;
End;



Procedure Add;
Var ch:Char;
		norm:Boolean;
		s_v2,s_v1,s_mask:String;
		v2,i,u,l,v1:Integer;
		mask,mult:Cardinal;
Begin
	ch:=c;Read(c);
	if c='G' then norm:=true else norm:=false;
	Read(c);

	SkipTabs;

	repeat Read(c) {Reading ip}
	until c=#9;

	SkipTabs;
	s_v1:='';
	while c<>#9 do begin
		s_v1:=s_v1+c;            {Reading first node}
		Read(c);
	end;
	v1:=Find(s_v1);

	SkipTabs;

	s_mask:='';
	while c<>#9 do begin
		s_mask:=s_mask+c;
		Read(c);
	end;

	l:=length(s_mask);
	if s_mask='-' then mask:=inf else begin
		mask:=0;if (s_mask='0x')or(s_mask='-0x') then Sdohnite;
		if s_mask[1]='-' then u:=2 else u:=1;
		mult:=10;
		if (l>=u+1)and(s_mask[u]='0')and(s_mask[u+1]='x') then begin
			mult:=16;u:=u+2;
		end;
		for i:=u to l do mask:=mask*mult+Digit(s_mask[i]);
		if mask<>0 then
		if s_mask[1]='-' then mask:=inf-(mask-1);
	end;

	while not EoLn do begin
		SkipTabs;
		if EoLn then break;
		s_v2:='';

		while (c<>#9)and (not EoLn) do begin
			s_v2:=s_v2+c;
			Read(c);
		end;
                if EoLn and (c<>#9)then s_v2:=s_v2+c;
                v2:=Find(s_v2);if v1=v2 then sdohnite;
                if norm then Modify(v1,v2,ch,mask) else Modify(v2,v1,ch,mask);
	end;
End;

Procedure Query;
Var j,v1,v2,i:Integer;
		s_ans,s_v1,s_v2:String;
    rts,t,tec,ans:Cardinal;
Begin
	for i:=1 to 5 do Read(c);
	SkipTabs;

	repeat Read(c) {Reading ip}
	until c=#9;
        SkipTabs;
	s_v1:='';
	while c<>#9 do begin
		s_v1:=s_v1+c;
		Read(c);
	end;
	SkipTabs;
	s_v2:='';
	while (c<>#9)and(not EoLn) do begin
		s_v2:=s_v2+c;
		Read(c);
	end;
        if EoLn and (c<>#9) then s_v2:=s_v2+c;
	v1:=Find(s_v1);v2:=Find(s_v2);if v1=v2 then sdohnite;
	rts:=0;
	for i:=0 to 31 do begin
		Inc(tuse);
		DFS(v1,i,v2);t:=1 shl i;
		if use[v2]=tuse then rts:=rts or t;
	end;
	ans:=0;
	for i:=0 to 7 do begin
		tec:=(rts shr (i*4)) and 15;
		if odd(i) then ans:=ans and (not tec) else ans:=ans or tec;
	end;
	s_ans:='';
	if (ans and 8)<>0 then s_ans:=s_ans+'A';
	if (ans and 4)<>0 then s_ans:=s_ans+'R';
	if (ans and 2)<>0 then s_ans:=s_ans+'W';
	if (ans and 1)<>0 then s_ans:=s_ans+'X';
	if s_ans='' then s_ans:='no';
	WriteLn(s_v1,' has ',s_ans,' rights on ',s_v2,'.');
End;

Begin
	Assign(input,'tts.in');
	Assign(output,'tts.out');
	Reset(input);ReWrite(output);
	Init;tuse:=0;
	while not EoF do begin
		repeat Read(c);{Reading time}
		until c=#9;

		SkipTabs;

		if c in['+','-','='] then Add else Query;
		ReadLn;
	end;
End.