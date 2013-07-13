#include <fstream>

using namespace std;


int mas[100000];
int n,m,k;

void addone(int l, int r)
{
  for (int i=l; i<=r; i++)
    mas[i]=(mas[i]+1)%k;
}

int get(int l, int r)
{
   int ans=0;
  for (int i=l; i<=r; i++)
    ans+=mas[i];
  return ans;
}

int main()
{
  ifstream fin("sum.in");
  ofstream fout("sum.out");
  int n,m;
  fin >> n >> k >> m;
  for (int i=0; i<n; i++)
    mas[i]=0;
  for (int i=0; i<m ; i++)
  {
    int s,x,y;
    fin >> s >> x >> y;
   if (s==1)
      addone(x-1,y-1);
    else
      fout << get(x-1,y-1) << '\n';
  }
  fin.close();
  fout.close();
}