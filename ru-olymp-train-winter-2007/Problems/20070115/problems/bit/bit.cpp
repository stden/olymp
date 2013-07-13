#include <vector>
#include <iostream>
#include <fstream>
#include <fcntl.h>
#include <unistd.h>

using namespace std;

class TestIO{
protected:
  int n;
  vector<char> pattern;
  bool result;
public:
  TestIO(istream &is){
    is >> n;
    pattern.reserve(n);
    for (int i=0 ; i<n ; i++){
      char c;
      is >> c;
      pattern.push_back(c-'a'+1);
    }
  };
  
  friend ostream& operator<<(ostream &os, const TestIO &data){
    if (data.result)
      return os << "YES" << endl;
    else
      return os << "NO" << endl;
  };
};


class Solution : public TestIO{
  class OkSub{
  public:
    int lr[4];
    int one[4];
    OkSub(){
      for (int i=0 ; i<4 ; i++){
	  lr[i] = 0;
	  one[i] = 0;
      }
      
     };
  };
  

  vector<OkSub> ok;
  
  static const char third[4][4];

  bool solveOne(int end, char one){
    int &o = ok[end].one[one];
    if (o){
      return o-1;
    }
    o = 1;
    char c = third[pattern[end-2]][pattern[end-1]];
    if ((c == one)&&(solveAdded(end-2,0)))
	o = 2;
    c = third[pattern[end-1]][one];
    if ((c!=0)&&(solveOne(end-1,c)))
	o = 2;
    return o-1;
  };


  bool solveAdded(int end, char added){    
    char oldEnd;
    int &o = ok[end].lr[added];
    if (o){
      return o-1;
    }
    if (added){
      end++;
      oldEnd = pattern[end-1];
      pattern[end-1] = added;
    }
    
    o = 1;
    char c = third[pattern[end-2]][pattern[end-1]];
    if (c != 0){
      if (solveAdded(end-2,0) ||
	  solveAdded(end-2,c))
	o = 2;
    };
    if (solveOne(end-1,(pattern[end-1]%3)+1) ||
	solveOne(end-1,((pattern[end-1]+1)%3)+1))
      o = 2;

    if (added){
      pattern[end-1] = oldEnd;
    };
    
    return o-1;
  }

public:
  Solution(istream &is) : TestIO(is), ok(n+1,OkSub()){
    if (third[pattern[0]][pattern[1]])
      ok[2].lr[0] = 2;
    for (int i=0 ; i<4 ; i++){
      if (third[pattern[0]][i])
	ok[1].lr[i] = 2;
      else
	ok[1].lr[i] = 1;
    }

    char c = third[pattern[0]][pattern[1]];
    if (c)
      ok[2].one[c] = 2;
    result = solveAdded(n,0);
  };
};

const char Solution::third[4][4] = {
  {0,0,0,0},
  {0,0,3,2},
  {0,3,0,1},
  {0,2,1,0}
};

int main(){
	close(0); open("bit.in", O_RDONLY);
	close(1); open("bit.out", O_WRONLY|O_CREAT|O_TRUNC, 0666);
//  ofstream ofs("bit.out");
//  ifstream ifs("bit.in");
  int n;
  cin >> n;
  for (int i=0 ; i<n ; i++)
    cout << Solution(cin);
};

