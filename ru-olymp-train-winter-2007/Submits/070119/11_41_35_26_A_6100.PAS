{$M 50000000}
uses
    binsearch;
var
	N, l, m, r : longint;
    fuck : boolean = false;
    ans1, ans2 : boolean;

begin
    N := GetN;
    l := 0;
    r := N + 1;
    while l < r - 1 do
     begin
        m := (l + r) div 2;
        ans1 := query(m);
        if not fuck then
         begin
            ans2 := query(m);
            if ans1 <> ans2 then
             begin
                ans1 := query(m);
                fuck := true;
             end;
         end;
        if ans1 then
            r := m
        else
            l := m;
     end;
    answer(r);
end.
