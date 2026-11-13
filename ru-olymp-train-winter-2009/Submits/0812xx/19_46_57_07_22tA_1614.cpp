#include <fstream>
#include <iostream>

using namespace std;

const int maxL=1048576, maxn=131072;

int kol[6][maxL+1], mod[maxL+1];
int k;


void init2(int L, int R, int i)
{
    kol[0][i]=R-L+1;
    if (R-L>0)
      {
      init2(L,(L+R)/2,2*i);
      init2((L+R)/2+1,R,2*i+1);
      }
}

void init(int n)
{
  for (int i=0; i<maxL+1; i++)
    {
      for (int j=1;j<6; j++)
	kol[j][i]=0;	
      mod[i]=0;
    }
  init2(1,maxn,1);
}

bool inpred(int x, int l, int r)
{
  return (x>=l && x<=r);
}

void addone(int L, int R, int l,int r, int i)
{
  if (L>r || R<l)
    return;
  else
    if (inpred(L,l,r) && inpred(R,l,r))
    {
      int buf = kol[k-1][i];
      for (int j=k-1; j>0; j--)
	  kol[j][i]=kol[j-1][i];
      kol[0][i]=buf;
      if (R-L>0)
	{
	  mod[i]++;
	}	
    }
  else
    {
      if (mod[i])
	{ 
	  for (int q=1; q<=mod[i]; q++)
	  {
	      int buf = kol[k-1][2*i+1];
	     for (int j=k-1; j>0; j--)
	      kol[j][2*i+1]=kol[j-1][i*2+1];
	      kol[0][2*i+1]=buf;
	       buf = kol[k-1][2*i];
	     for (int j=k-1; j>0; j--)
	      kol[j][2*i]=kol[j-1][2*i];
	      kol[0][2*i]=buf;
	  }
	  mod[i*2]+=mod[i];
	  mod[2*i+1]+=mod[i];
	  mod[i]=0;
	}
      addone(L,(L+R)/2,l,r,2*i);
      addone((L+R)/2+1,R,l,r,2*i+1);

      for (int j=0; j<=k-1; j++)
	kol[j][i]=kol[j][i*2]+kol[j][i*2+1];
    }
}

int get(int L,int R, int l, int r, int i)
{
  if (L>r || R<l)
    return 0;
  else
    if (inpred(L,l,r) && inpred(R,l,r))
    {
      int sum=0;
      for (int j=1; j<=k-1; j++)
	sum+=j*(kol[j][i]);
     // cout << sum << '\n';
      return sum;
    }
  else
    {
	if (mod[i])
	{ 
	  for (int q=1; q<=mod[i]; q++)
	  {
	      int buf = kol[k-1][2*i+1];
	     for (int j=k-1; j>0; j--)
	      kol[j][2*i+1]=kol[j-1][i*2+1];
	      kol[0][2*i+1]=buf;
	       buf = kol[k-1][2*i];
	     for (int j=k-1; j>0; j--)
	      kol[j][2*i]=kol[j-1][2*i];
	      kol[0][2*i]=buf;
	  }
	  mod[i*2]+=mod[i];
	  mod[2*i+1]+=mod[i];
	  mod[i]=0;
	 }
      return get(L,(L+R)/2,l,r,2*i)+get((L+R)/2+1,R,l,r,2*i+1);
    } 
}

int main()
{
  ifstream fin("sum.in");
  ofstream fout("sum.out");
  int n,m;
  fin >> n >> k >> m;
  init(n);
  for (int i=0; i<m ; i++)
  {
    int s,x,y;
    fin >> s >> x >> y;
   if (s==1)
      addone(1,maxn,x,y,1);
    else
      fout << get(1,maxn,x,y,1) << '\n';
  }
  fin.close();
  fout.close();
}