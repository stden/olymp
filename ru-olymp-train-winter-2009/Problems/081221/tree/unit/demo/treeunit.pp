unit treeunit;

{$link treeunitc.o}
{$linklib c}

interface

uses CTypes;

  procedure init;cdecl;external;

  function getN:longint;cdecl;external;

  function getA(edgeNum:ctypes.cint32):longint;cdecl;external;

  function getB(edgeNum:ctypes.cint32):longint;cdecl;external;

  function query(edgeNum:ctypes.cint32):longint;cdecl;external;

  procedure report(vertexNum:ctypes.cint32);cdecl;external;


implementation


end.
