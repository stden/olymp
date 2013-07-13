{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
uses testjury, strings;
const MaxL=10000;
var a:array [0..MaxL] of boolean;

function Result (Name, Pattern:PChar):boolean;
var i, j, t, p:integer;
    c, cs, q:char;
    r:boolean;
begin
(*
v def: a[m][n]=comps (string [m], pattern [n])
v ********************************************
v if (pattern [n]=='*') a[m][n]=a[m+1][n] | a[m][n+1] ;
v else if (pattern [n]=='?') a[m][n]=a[m+1][n+1];
v else if (pattern [n]==string [m]) a[m][n]=a[m+1][n+1];
v else a[m][n]=0;
v comps (string, "") = (string [0] == 0);
*)
(*int i, j, t, p;
/*char *a=malloc (1 + max (t=strlen (string), p=strlen (pattern)));*/
char r, a[512];
register char c;*)
 (* optimization 1: compare starting parts of strings *)
  repeat
    c:=pattern [0];
    cs:=Name[0];
    if c='*' then break;
    if c=#0 then begin Result:=cs=#0; exit end;
    if cs=#0 then begin Result:=false; exit end;
    if (c<>'?') and (c<>cs) then
      begin Result:=false; exit end;
    inc (pattern); inc (Name);
  until false;

  if pattern[1]=#0 then begin Result:=true; exit end;    (* '*' *)

  if (pattern[1]='*') and (pattern[1]<>'?') and
     (pattern[2]='*') and (pattern[3]=#0) then
     begin Result:=StrScan (Name, pattern [1])<>nil; exit end;
     (* something like '*.*' *)

  t:=StrLen (Name);
  p:=StrLen (pattern);

  fillchar (a[0], sizeof (a), 0);
  a[t]:=true;
  for j:=p-1 downto 0 do
    case Pattern[j] of
      '*':begin
	    r:=false;
            for i:=t downto 0 do begin
              r:=r or a[i];
              a[i]:=r;
            end;
          end;
      '?':begin
            move (a[1], a[0], t);
            a[t]:=false;
	  end
      else begin
	q:=pattern [j];
	for i:=0 to t do
	  if Name [i]=q then a[i]:=a[i+1] else a[i]:=false;
      end;
    end;
  Result:=a[0];
end;

var s1, s2:array [0..MaxL] of char;
    l1, l2:integer;
begin
  ci ('pattern.in'); ao ('pattern.out');
  while not eoln do begin
    s1[l1]:=nextchar;
    test (s1[l1] in ['a'..'z', '.', '?', '*']);
    inc (l1);
  end;
  s1[l1]:=#0;
  reql (Reject);
  while not eoln do begin
    s2[l2]:=nextchar;
    test (s2[l2] in ['a'..'z', '.']);
    inc (l2);
  end;
  s2[l2]:=#0;
  reql (Reject);
  reqeof;
  if Result (s2, s1) then writeln ('YES') else writeln ('NO');
end.