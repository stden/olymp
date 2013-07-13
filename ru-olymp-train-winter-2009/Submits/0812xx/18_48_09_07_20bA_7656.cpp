#include <fstream>
#include <string>

using namespace std;

ifstream fin("aplusminusb.in");
ofstream fout("aplusminusb.out");

const int maxn=10000;

struct bignum
{
  int d[maxn+1];
  int l;
  bool z; 
};


  

void swap(bignum &a, bignum &b)
{
  bignum c = a;
  a=b;
  b=c;
}

int more(bignum &a, bignum &b)
{
  int i;
  for (i=maxn; i>=0; i--)
  {
    if (a.d[i]>b.d[i])
      return 1;
    if (a.d[i]<b.d[i])
      return 2;
  }
  return 3;
}

void subs(bignum &a, bignum &b, bignum &c)
{
  int i, buf;
  if (more(a,b)==1 || more(a,b)==3) c.z=true;
  else c.z=false;
  buf =0;
  if (c.z)
   for (i=0; i<=maxn; i++)
    {
      buf = a.d[i]-b.d[i]-buf;
      if (buf<0)
      {
	c.d[i]= buf+10;
	buf = 1;
      }
      else
      {
	c.d[i]= buf;
	buf = 0;
      }
    }
  else
  for (i=0; i<=maxn; i++)
    {
      buf = b.d[i]-a.d[i]-buf;
      if (buf<0)
      {
	c.d[i]= buf+10;
	buf = 1;
      }
      else
      {
	c.d[i]= buf;
	buf = 0;
      }
    };


}

void writestupid(bignum &a)
{
    if (!a.z) fout << '-';
  int i =10000;
  while (a.d[i]==0 and i>0) i--;
  for (i=i; i>=0; i--)
    fout << a.d[i];
}



void readbignum (bignum &a)
{

  for (int i=0; i<=maxn; i++)
    a.d[i]=0;
  string str;
  fin >> str;
  int j=0,i;
  for (i=str.length()-1; i>=0; i-- )
    a.d[j++]=int(str[i])-int('0');
  a.l=--j;
}

int main()
{
  bignum a,b,c;
  readbignum(a);
  readbignum(b);
  subs(a,b,c);
  writestupid(c);
}