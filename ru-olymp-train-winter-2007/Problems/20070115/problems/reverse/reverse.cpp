#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int res,zac;
char A[10002], B[10002]; int N;

int spusti()
{
  int i,j,k;
  int cosi=1;
  i=zac; j=N-1;
  while ( cosi )
  {

//    if ( A[i]==19 ) { cosi=0; printf("AHA\n"); break; }
    // jedno a dvojciferne
    
    if ( i==j ) 
    {
      if ( !(A[i]%2) ) { cosi=0; res=1; break; }
      else { cosi=0; break; }
    }

    if ( i+1==j )
    {
      if ( A[i]==A[j] || A[i]==A[j]+11 )
      {
        cosi=0; res=1; break;
      }
      else { cosi=0; break; }
    }

    //vacsie
    
    if ( A[i]==A[j] )
    {
      i++; j--; 
    }

    else if ( A[i]==A[j]+1 )
    {
      A[i+1]+=10;
      i++;
      j--;
    }

    else if ( A[i]==A[j]+10 )
    {
      if (A[j]==9) { cosi=0; break; }
      k=j-1; 
      // znizime o jedna
      while (k>=i) 
      { 
        if (A[k]==0) A[k--]=9; else { A[k]--; break; } 
      }
        // ak uz nemame ani od coho odpocitavat
      if (k==i) { cosi=0; break; }
      i++; j--;
    }

    else if ( A[i]==A[j]+11 )
    {
      A[i+1]+=10;
      k=j-1;
      if (A[j]==9) { cosi=0; break; }
      while (k>=i)
      {
        if (A[k]==0) A[k--]=9; else { A[k]--; break; }
      }
      if (k==i) { cosi=0; break; }
      i++; j--;
    }

    else cosi=0;
    
    
  }
  return 0;
}

int main()
{
  int i,nieco;
  freopen("reverse.in", "r", stdin);
  freopen("reverse.out", "w", stdout);
  while (1)
  {
    nieco=1;
    i=0;
    res=0;
    scanf("%s ",A);
    N=strlen(A);
    if (A[0]=='0') break; 
    for (i=0; i<N; i++) 
    {
      A[i]=A[i]-'0';
    }
    // samotny program
    zac=0;
    
    //jednociferne a dvojciferne radsej zvlast...
    if (N==1) 
    {
      if (A[0]%2==0) res=1;
    }
    else if (N==2)
    {
      if (A[0]==A[1]) res=1;
      else if (A[0]==1 && (A[0]*10+A[1])%2==0) res=1;
    }
    
    //vacsie cisla
    else {
      if ( A[0]==1 ) 
      {
        nieco=1;
        if ( A[0]==1 && A[N-1]==0 ) nieco=0;
        //skopirujem si, aby som mohla druhykrat spustit
        for (i=0; i<N; i++) 
        {
          B[i]=A[i];
        }
        
        A[1]+=10;
        zac=1;
        spusti();
        if (!res  && nieco )
        {
          zac=0;
          //mvnem to spat
          for (i=0; i<N; i++) A[i]=B[i]; 
          spusti();
        }
      }
      else spusti();
    }
    if ( res ) printf("YES\n"); else printf("NO\n");
  }
  return 0;
}
