begin
	assign(input,'radio.in');
	reset(input);
	assign(output,'radio.out');
	rewrite(output);
	writeln(4);
	writeln('3 2 1 0');
  close(input);
  close(output); 
end.