#include <stdio.h>
#include <string.h>

int pow10[10] = { 1,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000 };
int digits(int N) { if (N<=9) return 1; return digits(N/10)+1; }
int Rev(int N) { if (N<=9) return N; return Rev(N/10) + (N%10) * pow10[ digits(N)-1 ]; }

int M[1000], N[1000], ml, nl, i;
char s[1000];
int _M[1000];

int verify(int od, int po) { 
  int i,ok;

  // prazdnu postupnost vieme vyrobit
  if (od>po) return 1;
  
  // jedno cislo vieme vyrobit iff je parne
  if (od==po) return ((M[od]%2)==0);
  
  // case #1: bez prenosov na okrajoch
  if ( M[po]==M[od] ) return verify(od+1,po-1); 

  // case #2: prenos z (po-1) do (po)
  if ( M[po]==M[od]+1 ) { 
    if (po==od+1) return 0; // pre 2ciferne takato situacia nevyhovuje, napr. (2)(1)

    // vratime prenos o rad nizsie
    M[po-1]+=10;
    return verify(od+1,po-1);
  }

  // case #3: prenos z (od) do (od+1)
  if ( M[po]==M[od]+10 ) {
    if (po==od+1) return 0; // pre 2ciferne ani takato situacia nevyhovuje, napr. (12)(2)
    if (M[od]==9) return 0; // sucet 19 vyrobit nevieme

    // skontrolujeme, ci je vnutorne cislo kladne 
    for (ok=0,i=od+1;i<po;i++) if (M[i]!=0) { ok=1; break; }
    if (!ok) return 0; // vnutorne cislo je nula, teda nevyhovuje
    // od vnutorneho cisla odcitame jednotku, ktora tam prisla prenosom
    i=od+1; while (1) { if (M[i]==0) M[i++]=9; else { M[i]--; break; } }
    
    return verify(od+1,po-1); 
  }

  // case #4: oba prenosy
  if ( M[po]==M[od]+11 ) { // oba prenosy
    if (po==od+1) return 1; // pre 2ciferne moze nastat a vyhovuje, napr. (13)(2)
    if (M[od]==9) return 0; // sucet 19 vyrobit nevieme
    
    // vratime prenos o rad nizsie
    M[po-1]+=10;
    // od (uz kladneho) vnutorneho cisla odcitame jednotku, ktora tam prisla prenosom
    i=od+1; while (1) { if (M[i]==0) M[i++]=9; else { M[i]--; break; } }
    return verify(od+1,po-1);
  }

  return 0;
}

int main(void){
  while (1) {
    scanf("%s ",s);
    ml=strlen(s); bzero(M,sizeof(M)); for (i=0;i<ml;i++) M[ml-i-1]=s[i]-'0';

    // ak sme nacitali nulu, koncime
    if (ml==1) if (M[0]==0) break; 

    // odzalohujeme M, lebo mozno ideme robit dva testy
    memcpy(_M,M,sizeof(M));

    // case #1: N a M su rovnako dlhe. 
    // nenastava, ak je M tvaru 1.....0, lebo N by zacinalo nulou
    if ( (M[0]!=0) || (M[ml-1]!=1) ) 
      if (verify(0,ml-1)) { printf("YES\n"); continue; }

    // case #2: N je o 1 cifru kratsie ako M
    // ma zmysel len ak M zacina jednotkou a je aspon dvojciferne
    if (ml>1) if (_M[ml-1]==1) {
      memcpy(M,_M,sizeof(M));
      M[ml-2]+=10;
      if (verify(0,ml-2)) { printf("YES\n"); continue; }
    }

    printf("NO\n");
  }
  return 0;
}
