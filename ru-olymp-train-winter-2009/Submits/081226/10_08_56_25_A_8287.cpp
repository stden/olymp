#include "vector"
#include "fstream"
#include "stack"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "algorithm"
#include "string"
#include "stdlib.h"

using namespace std;

char str[6000006]="11212";

char one[10000]="11212";
char two[20000]="1121212";
int cnt[2]={0};
int cn[6000006];
int sm[6000006];
int sm1, sm2;
int sum1[300];
int sum2[300];
int size= 0;

void count_sum()
{
	cn[0]=0;
	sm[0]=0;
	for(int i = 1; i<size; i++)
	{
		cn[i] = cn[i-1] + cnt[str[i-1]-'1'];
		sm[i] = sm[i-1] + ((str[i-1] == '1') ? (sm1) : (sm2));
	}
}

void count_sum(char a[], int s[], int n)
{
	s[0] = 0;
	for(int i = 1; i < n; i++)
	{
		s[i] = s[i-1] + a[i-1]-'0';
	}
}

int init(char a[], int n)
{
	int prev_n=1;
	int nn = 0;
	for(int u = 0; u < 2; u++)
	{
		nn = n;
		for(int i = prev_n; i<n;i++)
		{
			if(a[i] == '1')
			{
				a[nn++]='1';
				a[nn++]='1';
				a[nn++]='2';
				a[nn++]='1';
				a[nn++]='2';
			}
			else
			{
				a[nn++]='1';
				a[nn++]='1';
				a[nn++]='2';
				a[nn++]='1';
				a[nn++]='2';
				a[nn++]='1';
				a[nn++]='2';
			}
		}
		prev_n = n;
		n=nn;
	}
	return n;
}

void init()
{
	int prev_n=1;
	int n=5;
	int nn = 0;
	size=0;
	while(n < 6000000)
	{
		nn = n;
		for(int i = prev_n; i<n && nn < 6000000;i++)
		{
			if(str[i] == '1')
			{
				str[nn++]='1';
				str[nn++]='1';
				str[nn++]='2';
				str[nn++]='1';
				str[nn++]='2';
			}
			else
			{
				str[nn++]='1';
				str[nn++]='1';
				str[nn++]='2';
				str[nn++]='1';
				str[nn++]='2';
				str[nn++]='1';
				str[nn++]='2';
			}
		}
		prev_n = n;
		n=nn;
	}
	size = n;
	//printf("size = %d n = %d\n", n);
}

int res(int i)
{
	int l = 0, r = size;
//   	printf("searching %d\n", i);
	while(l+1<r)
	{		
		int m = (l+r)/2;
//   		printf("l=%d, r=%d, m=%d, val=%d\n", l, r, m, cn[m]);
		if(cn[m] < i)	
			l=m+1;
		else
			r=m;
	}
//  	printf("found %d in %d\n", i, l);
//  	printf("%d + %d  (sum[%d])\n", sm[l], ((str[l] == '1') ? sum1 : sum2)[i-cn[l]], i-cn[l]);
	return sm[l] + ((str[l] == '1') ? sum1 : sum2)[i-cn[l]];
}

int main()
{
	freopen("digitsum.in", "rt", stdin); 
	freopen("digitsum.out", "wt", stdout);
	int t;
	cin >> t;
	cnt[0]=init(one, 5);
	cnt[1]=init(two, 7);
	count_sum(one, sum1, cnt[0]);
	count_sum(two, sum2, cnt[1]);
	sm1 = sum1[cnt[0]-1];
	sm2 = sum2[cnt[1]-1];
	init();
	count_sum();
// 	for(int i = 0; i < 20; i++)
// 		cout << sum1[i] << endl;
	for(int i = 0; i < t; i++)
	{
		int a, b;
		scanf("%d %d", &a, &b);
		//cin >> a >> b;
		cout << res(b)-res(a-1) << endl;
	}
	return 0;
}