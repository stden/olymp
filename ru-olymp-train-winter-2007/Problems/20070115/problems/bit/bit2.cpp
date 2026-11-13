#include <vector>
#include <iostream>
#include <fstream>

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
      //      cout << c;
    }
    //    cout << " " << n<< endl;
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
    int lr[4][4];
    OkSub(){
      for (int i=0 ; i<4 ; i++)
	for (int j=0 ; j<4 ; j++)
	  lr[i][j] = 0;
     };
  };
  

  vector<vector<OkSub> > ok;
  
  static const char third[4][4];

  void enter(int &begin, int &end, char l, char r, char &oldBegin, char &oldEnd){
    if (l!=0){
      begin--;
      oldBegin = pattern[begin];
      pattern[begin] = l;
    }
    if (r!=0){
      end++;
      oldEnd = pattern[end-1];
      pattern[end-1] = r;
    }
  };

  void leave(int begin, int end, char l, char r, char oldBegin, char oldEnd){
    if (l!=0){
      begin++;
      pattern[begin] = oldBegin;
    }
    if (r!=0){
      end--;
      pattern[end-1] = oldEnd;
    }
  };

  bool solve(int begin, int end, char l, char r){
    //    cout << "AIN" << endl;
    char oldBegin, oldEnd;
    int &o = ok[begin][end].lr[l][r];
    //	  cout << "IN " << begin << " " << end << " " 
    //	       << (char)(l+'a'-1) << " " << (char)(r+'a'-1) << " "  << endl;
    if (o){
      //      cout << "R " << begin << " " << end << " " 
      //	   << (char)(l+'a'-1) << " " << (char)(r+'a'-1) << " " << o << endl;
      return o-1;
    }
    for (int i=begin ; i<end-1 ; i++){
      char c = third[pattern[i]][pattern[i+1]];
      if (c != 0){
	if ((solve(begin,i,l,0) && solve(i+2,end,0,r)) ||
	    (solve(begin,i,l,c) && solve(i+2,end,0,r)) ||
	    (solve(begin,i,l,0) && solve(i+2,end,c,r))){
	  o = 2;
	  //	  cout << "OUT OK" << endl;
	  return 1;
	};
      }
      c = third[pattern[end-1]][r];
      if (c!=0){
	if (solve(begin,end-1,l,0)||
	    solve(begin,end-1,l,c)){
	  o = 2;
	  //	  cout << "OUT OK" << endl;
	  return 1;
	};
      };
      c = third[l][pattern[begin]];
      if (c!=0){
	if (solve(begin+1,end,0,r)||
	    solve(begin+1,end,c,r)){
	  o = 2;
	  //	  cout << "OUT OK" << endl;
	  return 1;
	};
      };
    }
    o = 1;
    //  cout << "OUT NOK" << endl;
    return 0;
  }

  

  void initOk(){
    for (int p=0 ; p<n+1 ; p++){
      for (int i=0 ; i<4 ; i++){
	for (int j=0 ; j<4 ; j++){
	  if ((i==0) && (j==0))
	    ok[p][p].lr[i][j] = 2;
	  else
	    ok[p][p].lr[i][j] = 1;
	  ok[p+1][p].lr[i][j] = 1;
	  if ((i!=0)&&(j!=0))
	    ok[p][p+1].lr[i][j] = 1;
	}
	if (third[pattern[p]][i]){
	  ok[p][p+1].lr[0][i] = 2;
	  ok[p][p+1].lr[i][0] = 2;
	}
	else{
	  ok[p][p+1].lr[0][i] = 1;
	  ok[p][p+1].lr[i][0] = 1;
	}
      }
    }
  };

public:
  Solution(istream &is) : TestIO(is), ok(n+2, vector<OkSub>(n+2,OkSub())){
    initOk();
    result = solve(0,n,0,0);
  };
};

const char Solution::third[4][4] = {
  {0,0,0,0},
  {0,0,3,2},
  {0,3,0,1},
  {0,2,1,0}
};

int main(){
  //  ofstream ofs("bit.out");
  //  ifstream ifs("bit.in");
  int n;
  cin >> n;
  for (int i=0 ; i<n ; i++)
    cout << Solution(cin);
};

