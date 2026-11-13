#include <vector>
#include <iostream>
#include <fstream>

#define REP(i,n) for(unsigned int i=0;i<(n);i++)

using namespace std;

class TestIO{
protected:
  unsigned int result;
  unsigned int n,k;
  vector<vector<int> > imps;
public:
  TestIO(istream &is) : result(0){
    is >> n >> k;
    imps = vector<vector<int> >(k,vector<int>(n));
    REP(i,k)
      REP(j,n){
	is >> imps[i][j];
    }
  };
  
  friend ostream& operator<<(ostream &os, const TestIO &data){
    if (data.result)
      return os << "YES" << endl;
    else
      return os << "NO" << endl;
  };
};

class Solver : public TestIO{
public:
  Solver(istream &is) : TestIO(is){}

  int solve(){
    vector<int> data(n);
    REP(i,n) data[i] = i;
    REP(j,100000){
      bool ok = true;
      REP(i,n){
	int im = lrand48()%k;
	data[i] = imps[im][i];
	if (data[i] != 0)
	  ok = false;
      }
      if (ok) return true;
    }
    return false;
  }
};



int main(){
  ifstream inFile("bit2.in");
  ofstream outFile("bit2.out");

  unsigned int T;
  inFile >> T;
  REP(i,T){
    Solver solver(inFile);
    solver.solve();
    outFile << solver;
  }
  return 0;
}
