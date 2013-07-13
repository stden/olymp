uses binsearch;
var
n:integer;
lo,mid,hi:integer;
waslay:boolean;
function query1(i:integer):boolean;
begin
  if i<=n then begin
    if waslay then query1:=query(i)
    else if query(i) then begin
        if query(i) then query1:=true
        else begin
          query1:=query(i);
          waslay:=true;
        end;
      end
      else begin
        if query(i) then begin
          query1:=query(i);
          waslay:=true;
        end
        else query1:=false;
      end;
    end
  else query1:=true;
end;
procedure isnotbigger;
begin
  hi:=mid+1;
  mid:=(lo+hi) div 2;
end;
procedure isbigger;
begin
  lo:=mid+1;
  mid:=(hi+lo)div 2;
end;
begin
  n:=getN;
  lo:=1;
  hi:=n+2;
  mid:=(hi+lo) div 2;
  waslay:=false;
  while true do begin
    if mid=lo then break;
    if (hi=lo+2) then begin
//      if query1(mid) then begin
        if query1(lo) then break
        else begin
          lo:=mid;
          break;
        end;
{
      end;

      else begin
        lo:=hi;
        break;
      end;
}
    end;
    if query1(mid) then begin
      isnotbigger;
    end
    else begin
      isbigger;
    end;
  end;
  answer(lo);
end.