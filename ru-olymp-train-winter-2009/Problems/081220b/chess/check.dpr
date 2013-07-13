{$O-,Q+,R+}
uses SysUtils, testlib;

const Rook=0;
      Queen=1;
      King=2;

      White=1;
      Black=2;


var b:array [0..9, 0..9] of integer;


procedure readfield (var f:instream; var x, y:integer);
var c:char;
begin
  c:=f.nextchar; 
  if not (c in ['a'..'h']) then f.quit (_PE, 'there is no vertical '+mp (c)); 
  x:=ord (c)-ord ('a')+1;
  c:=f.nextchar; 
  if not (c in ['1'..'8']) then f.quit (_PE, 'there is no horizontal '+mp (c)); 
  y:=ord (c)-ord ('1')+1;
end;


function readanypiece (var f:instream; var x, y:integer):integer;
var c:char;
begin
  Result:=-1;
  c:=f.nextchar;
  case c of
    'K':Result:=King;
    'Q':Result:=Queen;
    'R':Result:=Rook;
    else f.quit (_PE, 'There is no piece '+mp (c));
  end;
  readfield (f, x, y);
end;


procedure readpiece (var f:instream; var x, y:integer; isking:boolean; var isqueen:boolean);
var c:char;
begin
  c:=f.nextchar; f.test (isking xor (c<>'K')); f.test (c in ['K', 'Q', 'R']);
  isqueen:=c='Q';
  readfield (f, x, y);
end;


procedure onespace (var f:instream);
var c:char;
begin
  c:=f.nextchar; f.test (c=' ');
end;


type atmove=procedure (x, y, c, value:integer);



function allmoves (x, y, c, value:integer; func:atmove):integer;
var i, j, k:integer;
begin
  Result:=0;
  for i:=-1 to 1 do
    for j:=-1 to 1 do
      if (abs (i)+abs (j)>0) and ((value<>Rook) or (abs (i)+abs (j)<2)) then 
        for k:=1 to 8 do begin
          if c and b[x+k*i, y+k*j] = c then break;
          inc (Result);
          func (x+k*i, y+k*j, c, value);
          if (value=King) or (b[x+k*i, y+k*j]>0) then break;
        end;
end;

type iside=array [1..2] of integer;
     bside=array [1..2] of boolean;
     pos=record
       kx, ky, hx, hy:iside;
       d:bside;
       side:integer;
     end;
      

var checkedflag:boolean;
    p, inp:pos;
    q:bside;

procedure verify_ischecked (x, y, c, value:integer);
begin
  //writeln ('.', x, ' ', y, ' ', c, ' ', value);
  if (x=p.kx[3-c]) and (y=p.ky[3-c]) then checkedflag:=true;
end;


function ischecked:boolean;
var c:integer;
begin
  checkedflag:=false; c:=p.side;
  allmoves (p.kx[c], p.ky[c], c, King, verify_ischecked);
  if not p.d[c] then allmoves (p.hx[c], p.hy[c], c, ord (q[c]), verify_ischecked);
  Result:=checkedflag;
end;


procedure fillboard;
var i:integer;
begin
  for i:=1 to 2 do begin
    b[p.kx[i], p.ky[i]]:=i;
    if not p.d[i] then b[p.hx[i], p.hy[i]]:=i
  end;
end;


procedure clearboard;
var i:integer;
begin
  for i:=1 to 2 do begin
    b[p.kx[i], p.ky[i]]:=0;
    if not p.d[i] then b[p.hx[i], p.hy[i]]:=0
  end;
end;

function field (x, y:integer):string;
begin
  Result:=chr (x+96)+chr (y+48);
end;


const names:array [0..2] of string=('Rook', 'Queen', 'King');
      sides:array [1..2] of string=('White', 'Black');


var nx, ny, movescount:integer;
    NewPosValid:boolean;

procedure checknewpos (x, y, c, value:integer);
begin
  if (x=nx) and (y=ny) then NewPosValid:=true;
end;


procedure countmoves (x, y, c, value:integer);
var tp:pos;
begin
  tp:=p;
  clearboard;
  with p do begin
    if value=king then begin 
      kx[side]:=x; ky[side]:=y;
    end else begin
      hx[side]:=x; hy[side]:=y;
    end;
    side:=3-side;
    if not d[side] and (x=hx[side]) and (y=hy[side]) then begin
      d[side]:=true; hx[side]:=0; hy[side]:=0
    end;
  end;
  fillboard;

  if not ischecked then inc (movescount);

  clearboard;
  p:=tp;
  fillboard;
end;

function dumppos:string;
begin
  with p do begin
    if side=White then Result:=Result+'W ' else Result:=Result+'B ';
    Result:=Result+'WK'+field (kx[1], ky[1])+' ';
    if not d[1] then begin
      Result:=Result+'W';
      if q[1] then Result:=Result+'Q' else Result:=Result+'H';
      Result:=Result+field (hx[1], hy[1])+' ';
    end;
    Result:=Result+'BK'+field (kx[2], ky[2])+' ';
    if not d[2] then begin
      Result:=Result+'B';
      if q[2] then Result:=Result+'Q' else Result:=Result+'H';
      Result:=Result+field (hx[2], hy[2]);
    end;
  end;
end;

function answer (var f:instream):integer;
var x, y, moves, value:integer;
begin
  p:=inp; moves:=0;
  fillboard;

  with p do begin
    while not f.seekeof do begin
      value:=readanypiece (f, x, y);
      if (value<>King) and (q[side] xor (value=Queen)) then
        f.quit (_Wa, sides[side]+' has no '+names[value]);
      if f.nextchar<>'-' then f.quit (_PE, '"-" expected');
      readfield (f, nx, ny);
      NewPosValid:=false;
      if value=King then begin
        if (kx[side]<>x) or (ky[side]<>y) then
          f.quit (_Wa, 'There is no '+sides[side]+' King at '+field (x, y)+', only at '+field (kx[side], ky[side]));
      end else begin
        if d[side] then f.quit (_Wa, sides[side]+' lost its '+names[value]);
        if (hx[side]<>x) or (hy[side]<>y) then
          f.quit (_Wa, 'There is no '+sides[side]+' '+names[value]+' at '+field (x, y)+', only at '+field (hx[side], hy[side]));
      end;
      allmoves (x, y, side, value, checknewpos);
      f.seekeoln;
      f.reql (Accept);
      if not NewPosValid then f.quit (_wa, format (
        'Move of %s %s from %s to %s is invalid.',
        [sides[side], names[value], field (x, y), field (nx, ny)]
      ));
      clearboard;
      if value=king then begin 
        kx[side]:=nx; ky[side]:=ny;
      end else begin
        hx[side]:=nx; hy[side]:=ny;
      end;
      side:=3-side;
      if not d[side] and (nx=hx[side]) and (ny=hy[side]) then begin
        d[side]:=true; hx[side]:=0; hy[side]:=0
      end;

      fillboard;

      if ischecked then f.quit (_wa, format (
        'Move of %s %s from %s to %s makes or leaves the King checked.',
        [sides[3-side], names[value], field (x, y), field (nx, ny)]
      ));
      inc (moves);
      if moves>200 then f.quit (_Wa, 'More than 200 moves done.');
    end;
    if not d[1] or not d[2] then begin
      movescount:=0;
      allmoves (kx[side], ky[side], side, King, countmoves);
      if not d[side] then allmoves (hx[side], hy[side], side, ord (q[side]), countmoves);
      if movescount>0 then f.quit (_Wa, 'Not one of three cases listed in statement: '+dumppos);
    end;
    Result:=moves;
  end;
  clearboard;
end;


var i, j, jury, cont:integer;

begin
  with p do begin
    inf.noeoln; readpiece (inf, kx[1], ky[1], true, q[1]); onespace (inf);
    inf.noeoln; readpiece (inf, hx[1], hy[1], false, q[1]); inf.reql (Reject);
    inf.noeoln; readpiece (inf, kx[2], ky[2], true, q[2]); onespace (inf);
    inf.noeoln; readpiece (inf, hx[2], hy[2], false, q[2]); inf.reql (Reject);
    inf.reqeof;
    for i:=0 to 9 do begin b[i, 0]:=3; b[i, 9]:=3;
                           b[0, i]:=3; b[9, i]:=3 end;
    inf.test ((kx[1]<>hx[1]) or (ky[1]<>hy[1]));
    inf.test ((kx[1]<>kx[2]) or (ky[1]<>ky[2]));
    inf.test ((kx[1]<>hx[2]) or (ky[1]<>hy[2]));
    inf.test ((hx[1]<>kx[2]) or (hy[1]<>ky[2]));
    inf.test ((hx[1]<>hx[2]) or (hy[1]<>hy[2]));
    inf.test ((kx[2]<>hx[2]) or (ky[2]<>hy[2]));
    side:=Black;
  end;
  fillboard;
  inf.test (not ischecked);
  clearboard;
  inp:=p;
  jury:=answer (ans);
  cont:=answer (ouf);
  if jury<cont then quit (_Wa, i2s (cont)+' moves instead of '+i2s (jury))
  else
  if jury>cont then quit (_Fail, 'found '+i2s (cont)+' better than '+i2s (jury))
  else
  quit (_ok, ''); 
end.