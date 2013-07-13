#include <iostream>
#include <cstring>
#include <cmath>
#include <cstdlib>
#include <vector>
#include <string>
#include <map>
#include <algorithm>
using namespace std;

string sa,sb;

/*
struct tlong
{
  vector <int> a;
  int size;
  tlong()
  {
    size = 0;
  }
  tlong(string &s)
  {
    for(int i=0; i<(int)s.length(); i++)
    v.push_back( s[i] - '0' );
  }
}
*/

int a[1000000];

#define all(c) (c).begin(),(c).end()

int main()
{
  freopen("aplusminusb.in","r",stdin);
  freopen("aplusminusb.out","w",stdout);

  getline( cin, sa );
  getline( cin, sb );

  int n = max( (int)sa.size(), (int)sb.size() );

  bool z;
  if( (int)sa.length() != (int)sb.length() )
  {
    z = (int)sa.length() > (int)sb.length();
  } else
  {
    z = sa >= sb;
  }

  memset( a, 0, sizeof a);

  reverse( all(sa) );
  reverse( all(sb) );

  for(int i = 0; i<(int)sa.size(); i++)
    a[i+1] = sa[i] - '0';
  for(int i = 0; i<(int)sb.size(); i++)
    a[i+1] -= (sb[i] - '0');

  if( z == false )
  {
    for(int i=1; i<=n || a[i] != 0; i++)
    {
      if( a[i] > 0 )
      {
	a[i] -= 10;
	a[i+1] += 1;
      }
    }
  } else
  {
    for(int i=1; i<=n || a[i] != 0; i++)
    {
      if( a[i] < 0 )
      {
	a[i] += 10;
	a[i+1] -= 1;
      }
    }
  }

  if( !z ) printf("-");

  a[0] = 99999;
    
  while( a[0] > 1 && a[a[0]] == 0  ) a[0]--;

  for(int i = a[0]; i>0; i--)
    printf("%d", abs(a[i]));


  return 0;
}

