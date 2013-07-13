{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
uses Math,SysUtils,MD5;
type  stat = array[0..31] of byte;
      pcard = string[2];
      node = record
         cards: stat;
         ans,pl: longint;
      end;
const start: array [1..3] of byte = (12,10,10);
      hashsize = 3000000;
var hashtable: array[0..hashsize] of array of node;
    fp,i,j,powerm: byte;
    cur,best: integer;
    turn: string;
    c1,c2: char;
    cards: stat;
label doans;

function myhash(const c: stat;pa: longint): longint;
var i,res: longint;
begin
	res := 0;
   for i:=0 to 30 do res := res*7+c[i]+c[i+1] shl 5;
   res := res+pa*239;
   result := abs(res mod hashsize);
end;

function encode(v,m: char): byte;
var base,sh: byte;
begin
   base := 0; sh := 0;
   case m of
      'S': base := 0;
      'C': base := 1;
      'D': base := 2;
      'H': base := 3;
   end;
   case v of
      '7': sh := 0;
      '8': sh := 1;
      '9': sh := 2;
      'T': sh := 3;
      'J': sh := 4;
      'Q': sh := 5;
      'K': sh := 6;
      'A': sh := 7;
   end;
   result := base*8+sh;
end;

function decode(card: byte): pcard;
var base,sh: byte;
begin
   setlength(result,2);
   base := card div 8;
   sh := card mod 8;
   case base of
      0: result[2] := 'S';
      1: result[2] := 'C';
      2: result[2] := 'D';
      3: result[2] := 'H';
   else
      result[2] := 'N';
   end;
   case sh of
      0: result[1] := '7';
      1: result[1] := '8';
      2: result[1] := '9';
      3: result[1] := 'T';
      4: result[1] := 'J';
      5: result[1] := 'Q';
      6: result[1] := 'K';
      7: result[1] := 'A';
   end;
end;

function next(p: byte): byte; inline;
begin
   result := (p+1) mod 3;
end;

function isGood(ma,card: byte): boolean; inline;
var mc: byte;
begin
   mc := card div 8;
   result := (mc=ma) or (mc=powerm);
end;

function compare(const ma,va,mb,vb: byte): byte; inline;
begin
   if (ma=powerm) and (mb<>powerm) then
      result := 0 else
   if (ma<>powerm) and (mb=powerm) then
      result := 1 else
      result := ord(va<vb);
end;

function winner(a,b,c,pa,pb,pc: byte): byte; inline;
var ma,mb,mc,va,vb,vc: byte;
begin
   ma := a div 8; va := a mod 8;
   mb := b div 8; vb := b mod 8;
   mc := c div 8; vc := c mod 8;
   if compare(ma,va,mb,vb)=1 then
   begin
      ma := mb; va := vb; pa := pb;
   end;
   if compare(ma,va,mc,vc)=0 then
      result := pa else
      result := pc;
end;

function game(r,pa: byte): integer;
var turn: array[0..31] of integer;
    a,b,c,pb,pc,ma,np: byte;
    wins,hc,i,j: longint;
    ab,ac,equal: boolean;
    hs: ^stat;
begin
   for a:=0 to 31 do turn[a] := 100;
   if (r = 0) then exit(0);
   hc := myhash(cards,pa);
   for i:=0 to High(hashtable[hc]) do
   begin
      hs := @hashtable[hc][i].cards;
      equal := true;
      for j:=0 to 31 do
         if (hs^[j]<>cards[j]) then
         begin
            equal := false; break;
         end;
      if (equal) and (hashtable[hc][i].pl=pa) then
      	exit(hashtable[hc][i].ans);
   end;
   pb := next(pa); pc := next(pb);
   for a:=0 to 31 do
      if (cards[a]=pa) then
      begin
         ma := a div 8;
         ab := true; ac := true;
         for b:=0 to 31 do
            if isGood(ma,b) then
            begin
               if (cards[b] = pb) then ab := false;
               if (cards[b] = pc) then ac := false;
            end;
         for b:=0 to 31 do
            if (cards[b]=pb) and (ab or isGood(ma,b)) then
               for c:=0 to 31 do
                  if (cards[c]=pc) and (ac or isGood(ma,c)) then
                  begin
                     cards[a] := 0;
                     cards[b] := 0;
                     cards[c] := 0;
                     np := winner(a,b,c,pa,pb,pc);
                     if (random(100000)=0) or (np = 0) then
	                     wins := game(r-1,np);
                     if (np = 0) then inc(wins);
                     if (pa=0) then turn[a] := min(turn[a],wins);
                     if (pb=0) then turn[b] := min(turn[b],wins);
                     if (pc=0) then turn[c] := min(turn[c],wins);
                     cards[a] := pa;
                     cards[b] := pb;
                     cards[c] := pc;
                  end;
      end;
   result := 0;
   for a:=0 to 31 do
      if (turn[a] <> 100) and (turn[a]>result) then
         result := turn[a];
   i := length(hashtable[hc]);
   setlength(hashtable[hc],i+1);
   hashtable[hc][i].cards := cards;
   with hashtable[hc][i] do
   begin
   	ans := result;
   	pl := pa;
   end;
end;

begin
	RandSeed := 239;
	fillchar(hashtable,sizeof(hashtable),0);
	assign(input,'preference.in'); reset(input);
   readln(fp); dec(fp);
   for i:=1 to 3 do
   begin
      for j:=1 to start[i] do
      begin
         read(c1,c2);
         cards[encode(c1,c2)] := i;
         read(c1);
      end;
      readln;
   end;
	close(input);
   best := -1;
   for i:=0 to 30 do
      for j:=i+1 to 31 do
         if (cards[i]=1) and (cards[j]=1) then
         begin
            cards[i] := 0; cards[j] := 0;
            for powerm:=0 to 4 do
            begin
               cur := game(10,fp);
               if (cur > best) then
               begin
                  best := cur;
                  turn := decode(i)+' '+decode(j)+#13#10+decode(powerm*8)[2];
                  if (best = 10) then goto doans;
               end;
            end;
            cards[i] := 1; cards[j] := 1;
         end;
doans:
	assign(output,'preference.out'); rewrite(output);
   writeln(best);
   write(turn);
	close(output);
end.
