#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int M,N,ok;
int pow10[10] = { 1,10,100,1000,10000,100000,1000000,10000000,100000000,1000000000 };

int digits(int N) { if (N<=9) return 1; return digits(N/10)+1; }
int Rev(int N) { if (N<=9) return N; return Rev(N/10) + (N%10) * pow10[ digits(N)-1 ]; }

int main(void){
	close(0); open("reverse.in", O_RDONLY);
	close(1); open("reverse.out", O_WRONLY|O_TRUNC|O_CREAT, 0666);
  while (1) {
    scanf("%d ",&M);
    if (!M) break;
    if (M>10000000) { printf("DON'T KNOW\n"); continue; }
    for (ok=0,N=1;N<M;N++) if (M==N+Rev(N)) { printf("YES\n"); ok=1; break; }
    if (!ok) printf("NO\n");
  }
  return 0;
}
