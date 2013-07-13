{$ifdef VER70}
{$A+,B-,D+,E-,F+,G+,I+,L+,N+,O-,P+,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
{$else}
{$IFNDEF FPC}
{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P-,Q+,R+,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE CONSOLE}
{$else}
{$I+,O+,Q+,R+}
{$MODE DELPHI}
{$endif}
{$endif}
