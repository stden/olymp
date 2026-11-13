Program prg;

uses
  binsearch;

type
  integer = longint;

var
  l, r, m, n: integer;
  prl, lprl, rprl: integer;
  lied, last, now, now2, now3, now4: boolean;



begin
  n:=getN;
  l:=1; r:=n;
  lied:=false;
  prl:=-1;

 IF N>2 THEN
  while (r-l)>1 do begin
    m:=(r+l) div 2;
    now:=query(m);
    if (lied) then begin
      if (now = true) then begin
        r:=m;
      end else begin
        l:=m+1;
      end;
      continue;
    end else
    if (prl = -1) then begin
      prl:=m;
      lprl:=l;
      rprl:=r;
      if (now = true) then begin
        last:=true;
        r:=m;
      end else begin
        last:=false;
        l:=m+1;
      end;
      continue;
    end else

    begin
      if (now = false) and (last = false) then begin //////////
        lprl:=l;
        prl:=m;
        last:=false;
        l:=m+1;
      end else
      if (now = true) and (last = false) then begin  //////////
        now2:=query(prl);
        if (now2 = true) then begin
          lied:=true;
          r:=prl;
          l:=lprl;
        end else begin
          now2:=query(m);
          if (now2 = false) then begin
            lied:=true;
            l:=m+1;
          end else begin
            prl:=-1;
            r:=m;
          end;
        end;
      end else
      if (now = true) and (last = true) then begin    //////////
        rprl:=r;
        prl:=m;
        last:=true;
        r:=m;
      end else
      if (now = false) and (last = true) then begin   //////////
        now2:=query(prl);
        if (now2 = false) then begin
          lied:=true;
          l:=prl+1;
          r:=rprl;
        end else begin
          now2:=query(m);
          if (now2 = true) then begin
            lied:=true;
            r:=m;
          end else begin
            prl:=-1;
            l:=m+1;
          end;
        end;
      end;
    end;

  end;

  if (lied) then begin
    now:=query(l);
    if (now = true) then
    answer(l)
    else
    answer(l+1);
  end else
  if (prl = -1) and (r < n) then begin
    now:=query(l);
    now2:=query(l);
    if (now = now2) then begin
      if (now = true) then answer(l)
      else
      answer(l+1);
    end else
    now:=query(l);
    if (now = true) then answer(l)
    else
    answer(l+1);
  end else
  begin
    if (last = true) or (r >= n) then begin
      now:=query(r);
      now2:=query(r);
      if (now=true) and (now2 = true) then begin
        now3:=query(l);
        now4:=query(l);
        if (now3 = true) and (now4 = true) then begin
          answer(l);
        end else
        if (now4 = false) and (now3 = false) then begin
          answer(r);
        end else
        begin
          now:=query(l);
          if (now = true) then answer(l) else answer(r);
        end;
      end else
      if (now = false) and (now2 = false) then begin
        answer(r+1);
      end else begin
        now3:=query(r);
        if (now3 = true) then begin
          now4:=query(l);
          if (now4 = true) then answer(l)
          else
          answer(r);
        end else begin
          answer(r+1);
        end;
      end;
    end else begin

      now:=query(l);
      now2:=query(l);
      if (now=true) and (now2 = true) then begin
        now3:=query(l-1);
        now4:=query(l-1);
        if (now3 = true) and (now4 = true) then begin
          answer(l-1);
        end else
        if (now4 = false) and (now3 = false) then begin
          answer(l);
        end else
        begin
          now:=query(l-1);
          if (now = true) then answer(l-1) else answer(l);
        end;
      end else
      if (now = false) and (now2 = false) then begin
        answer(r);
      end else begin
        now3:=query(l);
        if (now3 = true) then begin
          now4:=query(l-1);
          if (now4 = true) then answer(l-1)
          else
          answer(l);
        end else begin
          answer(r);
        end;
      end;

    end;

  end;


end.
