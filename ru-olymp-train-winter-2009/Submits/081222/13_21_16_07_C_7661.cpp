#include <iostream>
#include <fstream>
using namespace std;

long long n;

int main()
{
  ifstream fin("room.in");
  ofstream fout("room.out");
  fin >> n;
  long long k=0, ans=0;
  k=n/3;
  ans = (k/2)*(8+6*(k-1));
  if (k%2==1)
    ans+= 6*(k/2)+4;
  if (n%3==1)
    ans+=2*k+1;
  if (n%3==2)
    ans+=2*(2*k+1);
  fout << ans;
}