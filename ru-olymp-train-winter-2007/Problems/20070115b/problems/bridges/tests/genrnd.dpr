uses
	sysutils, math;

const
	maxN = 20000;
	maxM = 200000;

type
	TEdge = record
		u, v : integer;
	end;

var
	n, k : integer;
	p : real;

	parent : array[1..maxN] of integer;
	sizes : array[1..maxN] of integer;
	start : array[1..maxN] of integer;

	m : integer;
	edges : array[0..maxM] of TEdge;
  	

procedure write_edge (u, v : integer);
begin
    if m = maxm then
        exit;
	inc (m);
	edges[m].u := min(u, v);
	edges[m].v := max(u, v);

end;

procedure make_tree;
var
	i : integer;

begin
	for i := 2 to k do
		parent[i] := random (i - 1) + 1;
end;

procedure make_sizes;
var
	i : integer;
	sum : integer;

begin
	sum := n;
	for i := 1 to k do begin
		sizes[i] := random (sum div (k - i + 1)) + 1;
		dec (sum, sizes[i]);
	end;
	inc (sizes[random (k)+1], sum);

	start[1] := 1;
	for i := 2 to k do
		start[i] := start[i-1] + sizes[i-1];
end;

procedure write_comp (k : integer);
var
	i : integer;

begin
	for i := 1 to trunc (random (sizes[k]) * random (sizes[k]) * p) do
		write_edge (start[k] + random (sizes[k]), start[k] + random (sizes[k]));
end;

procedure write_cycle (k : integer);
var
	i : integer;

begin
	for i := 1 to sizes[k] - 1 do
		write_edge (start[k] + i - 1, start[k] + i);
	write_edge (start[k] + sizes[k] - 1, start[k]);
end;

procedure write_output;
var
	i : integer;

begin
	writeln (n, ' ', m);
	for i := 1 to m do	
		writeln (edges[i].u, ' ', edges[i].v);
end;

function less (i, j : integer) : boolean;
begin
	if edges[i].u < edges[j].u then
		less := true
	else
		if edges[i].u > edges[j].u then
			less := false
		else
			less := edges[i].v < edges[j].v;
end;

procedure qsort (lo, hi : integer);
var
  i : integer;
  j : integer;
  tmp : TEdge;

begin
  edges[0] := edges[lo + random(hi - lo + 1)];
  i := lo;
  j := hi;
  while i <= j do begin
    while less (i, 0) do inc (i);
    while less (0, j) do dec (j);
    if i <= j then begin
      tmp := edges[i];
      edges[i] := edges[j];
      edges[j] := tmp;
      inc (i);
      dec (j);
    end;
  end;

  if i < hi then
    qsort (i, hi);
  if j > lo then
    qsort (lo, j);

end;

procedure qsort_edges;
begin
	qsort (1, m);
end;

procedure sift_edges;
var
	i, j : integer;

begin
	j := 0;
	for i := 1 to m do
		if ((j = 0) or ((j > 0) and ((edges[i].u <> edges[j].u) or (edges[i].v <> edges[j].v)))) and (edges[i].u <> edges[i].v) then begin
			inc (j);
			edges[j] := edges[i];
		end;
	m := j; 
end;

procedure write_tree;
var
	i : integer;

begin
	for i := 2 to k do
		write_edge (start[i] + random (sizes[i]), start[parent[i]] + random (sizes[parent[i]]));
end;

var
	i : integer;

begin
	decimalseparator := '.';
	if paramcount <> 3 then
		halt;

  	n := strtoint(paramstr(1));
  	k := strtoint(paramstr(2));
  	p := strtofloat(paramstr(3));
  
  	randseed := n + k + trunc (p * 1000);

  	make_tree;
  	make_sizes;

	m := 0;
	write_tree;
  	for i := 1 to k do
  		write_cycle (i);
  	for i := 1 to k do
  		write_comp (i);


	qsort_edges;
	sift_edges;
	write_output;
end.
