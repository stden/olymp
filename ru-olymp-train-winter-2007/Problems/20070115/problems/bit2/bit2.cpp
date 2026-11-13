#include <vector>
#include <iostream>
#include <fstream>
#include <utility>

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

class Graph{
private:
  vector<bool> isVisited;
  vector<int> visited;
protected:
  int n;
  vector<vector<int> > edges; 
public:
  Graph(int _n) : n(_n), edges(_n){
    REP(i,n)
      edges[i].reserve(10);
  }

  void addEdge(int v1,int v2){
    edges[v1].push_back(v2);
  }
  
  void visit(int v){
    if (isVisited[v])
      return;
    isVisited[v] = true;
    visited.push_back(v);
    REP(i,edges[v].size())
      if (!isVisited[edges[v][i]])
	visit(edges[v][i]);
  }

  vector<int> dfs(vector<int> start){
    isVisited = vector<bool>(n,false); 
    visited = vector<int>(0);
    REP(i,start.size())
      visit(start[i]);
    return visited;
  }
};

class Solver : public TestIO{
public:
  Solver(istream &is) : TestIO(is){}
  
  int pair2Int(int p1, int p2){ return p1*n + p2;}

  int revReachAll(){
    Graph g(n*n);
    REP(i,k) REP(j1,n) REP(j2,n)
      g.addEdge( pair2Int(imps[i][j1],imps[i][j2]),pair2Int(j1,j2));
    
    vector<int> start(1,0);

    return (g.dfs(start).size() == n*n);
  }

  int solve(){
    return (result = revReachAll());
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
