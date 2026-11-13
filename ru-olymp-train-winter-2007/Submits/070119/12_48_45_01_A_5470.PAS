uses binsearch;

var n,left,mid,right:integer;
	ans,ans1,ans2,canFalse:boolean;

begin
	n:=getN;
	left    := 1;
	right   := n+1;
	canFalse:=true;
	while (left<right) do begin
		mid := (left+right) shr 1;
		if (canFalse) then begin
			ans1 := query(mid);
			ans2 := query(mid);
			if (ans1=ans2) then begin
				ans := ans1;
			end
			else begin
				canFalse := false;
				ans := not(ans1 xor ans2 xor query(mid));
			end;
		end
		else begin
			ans := query(mid);
		end;
		if (ans) then begin
			right:=mid;			
		end
		else begin
			left := mid+1;
		end;
	end;
	answer(left);
end.