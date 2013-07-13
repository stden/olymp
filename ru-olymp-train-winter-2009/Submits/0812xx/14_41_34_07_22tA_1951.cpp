#include <fstream>

using namespace std;

const int maxL=1048576, maxn=131072;

int kol[6][maxL+1];
bool obr[maxL+1];
int k;


void init2(int L, int R, int i)
{
    kol[0][i]=R-L+1;
    if (R-L>0)
      {
      init2(L,L+(R-L+1)/2-1,2*i);
      init2(L+(R-L+1)/2,R,2*i+1);
      }
}

void init(int n)
{
  for (int i=0; i<maxL+1; i++)
    {
      for (int j=1;j<6; j++)
	kol[j][i]=0;
      obr[i]=false;
    }
  init2(1,maxn,1);
}

bool inpred(int x, int l, int r)
{
  return (x>=l && x<=r);
}

void addone(int L, int R, int l,int r, int i)
{
  if (obr[i]==false)
    kol[0][i]=R-L+1, obr[i]=true;
  if (L>r || R<l)
    return;
  else
    if ((R-L==0)/*inpred(L,l,r) && inpred(R,l,r)*/)
    {
      int buf = kol[k-1][i];
      for (int j=k-1; j>0; j--)
	kol[j][i]=kol[j-1][i];
      kol[0][i]=buf;
    }
  else
    {
      addone(L,L+(R-L+1)/2-1,l,r,2*i);
      addone(L+(R-L+1)/2,R,l,r,2*i+1);

      for (int j=0; j<=k-1; j++)
	kol[j][i]=kol[j][i*2]+kol[j][i*2+1];
    }
}

int get(int L,int R, int l, int r, int i)
{
   if (!inpred(l,L,R) && !inpred(r,L,R))
    return 0;
  else
    if (inpred(L,l,r) && inpred(R,l,r))
    {
      int sum=0;
      for (int j=1; j<=k-1; j++)
	sum+=j*kol[j][i];
      return sum;
    }
  else
    {
      return get(L,L+(R-L+1)/2-1,l,r,2*i)+get(L+(R-L+1)/2,R,l,r,2*i+1);
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