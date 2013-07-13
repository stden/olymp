{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;

procedure dispcolor (c:integer;var s:string);
begin
  asm
    mov ah, 3
    mov bh, 0
    int 10h
    mov ax, 1301h
    mov bl, byte ptr c
    push bp
    les bp, s
    mov ch, 0
    mov cl, es:[bp]
    inc bp
    int 10h
    pop bp
  end;
end;
var s, s2, sbl:string;
    pl, pc:integer;
    i:integer;
begin
  for i:=1 to 79 do sbl:=sbl+' ';
  readln (s);
  if (copy (s, 3, 5)='Облом') then
    begin pl:=5; pc:=12 end
  else
  if (copy (s, 3, 10)='Формат в/в') then
    begin pl:=10; pc:=13 end
  else
  if (copy (s, 3, 14)='Неверный ответ') then
    begin pl:=14; pc:=9 end
  else
  if (copy (s, 3, 2)='ok') then
    begin pl:=2; pc:=10 end;
  dispcolor (7, sbl); write (#13);
  if pl>0 then
    begin
      s2:=copy (s, 1, pl+4);
      dispcolor (pc, s2);
    end;
  writeln (copy (s, pl+5, 255));
  dispcolor (7, sbl); write (#13);
  while not eof do
    begin
      readln (s);
      writeln (s);
    end;
end.