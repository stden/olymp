#include <fstream>

const int inf=10000000;

using namespace std;

int mas[400000];
int next[400000];

int l=1;

int n,t,m;

void initadd(int x)
{
  next[l-1]=l;
  mas[l++]=x;
}

void addafter(int pos, int x)
{
  mas[l++]=x;
  int i=0, id=0;
  while (i<pos) 
    id=next[i], i++;
  next[id]=l-1;
}

void modify(int pos, int x)
{
  int i=0, id=0;
  while (i<pos) 
    id=next[i], i++;
  mas[id]=x;
}

int get(int l, int r, int p)
{
  int i=0, id=0,ans=0;
  while (i<l) 
    id=next[i], i++;
  while (i<=r)
  {
    if (mas[id]<=p)
      ans++;
    id=next[i]; i++;
  }
  return ans;
}

int main()
{
  ifstream fin("dynarray.in");
  ofstream fout("dynarray.out");
  fin >> n >> m;
  int x,y,o,q;
  for (int i=0; i<n; i++)
    fin >> x, initadd(x);
  
  for (int i=0; i<m; i++)
  {
    fin >> o;
    if (o==1)
      fin >> x >> y, modify(x,y);
    if (o==2)
      fin >> x >> y, addafter(x,y);
    if (o==3)
      fin >> x >> y >> q, fout << get(x,y,q) << '\n';
  }
  fin.close();
  fout.close();
}