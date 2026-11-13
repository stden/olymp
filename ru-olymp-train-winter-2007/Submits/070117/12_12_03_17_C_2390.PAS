program Restore;

var
    F:Text;

begin
    Assign(F,'restore.out');
    Rewrite(F);
    WriteLn(F,2);
    Close(F);
end.