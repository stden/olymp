#include <vector>
#include <iostream>
#include <fstream>
#include <algorithm>

#define N_MAX = 200
#define K_MAX = 10

#define REP(i,n) for(unsigned int i=0;i<(n);i++)
#define ALL(c) (c).begin(),(c).end()

using namespace std;

class Bit2Test{
protected:
  unsigned int n,k;
  vector<vector<int> > imps;
public:
  Bit2Test(unsigned int _n, unsigned int _k) : n(_n), k(_k), imps(vector<vector<int> >(k,vector<int>(n))){
    REP(j,k)
      REP(i,n)
      imps[j][i] = i;
  }

  virtual ~Bit2Test(){}

  void randomImp(int j){
    random_shuffle(ALL(imps[j]));
  }

  void randomImps(){
    REP(j,k)
      randomImp(j);
  }

  void shuffleImps(){
    random_shuffle(ALL(imps));
  }

  void shuffleStates(){
    vector<int> perm(n);
    REP(i,n) perm[i] = i;
    random_shuffle(ALL(perm));
    
    vector<int> newImp(n);
    REP(j,k){
      REP(i,n){
	newImp[perm[i]] = perm[imps[j][i]];
      }
      imps[j] = newImp;
    }
  }

  virtual void dump(ostream &os){
    os << n << " " << k << endl;
    REP(j,k){
      REP(i,n-1)
	os << imps[j][i] << " ";
      os << imps[j][n-1] << endl;
    }
  }
  friend ostream& operator<<(ostream &os, Bit2Test &test){
    test.dump(os);
    return os;
  }

  vector<vector<int> > getImps(){ return imps;}
};

class Cerny : public Bit2Test{
public:
  Cerny(int _n, int _k = 2) : Bit2Test(_n,_k){
    REP(i,n)
      imps[k-1][i] = (i+1)%n;
    REP(j,k-1){
      REP(i,n)
	imps[j][i] = i;
      int sing = lrand48()%n;
      imps[j][sing] = (sing+1)%n;
    }
  }
};

class RandomPerms : public Bit2Test{
public:
  RandomPerms(int n, int k = 2) : Bit2Test(n,k){
    randomImps();
  }
};

class Random : public Bit2Test{
public:
  Random(unsigned int n, unsigned int k = 2) : Bit2Test(n,k){
    REP(j,k) REP(i,n)
      imps[j][i] = lrand48()%n;
  }
};

class Graph{
private:
  vector<bool> isVisited;
  vector<int> visited;
protected:
  int n;
  vector<vector<int> > edges; 
public:
  Graph(int _n) : n(_n), edges(vector<vector<int> >(_n)){}
  void addEdge(int v1,int v2){
    edges[v1].push_back(v2);
  }
  
  void visit(int v){
    if (isVisited[v])
      return;
    isVisited[v] = true;
    visited.push_back(v);
    REP(i,edges[v].size())
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

class RandomUnreachable : public Bit2Test{
protected:
  int reach0(){
    Graph g(n);
    REP(i,k) REP(j,n)
      g.addEdge(imps[i][j],j);
    
    return (g.dfs(vector<int>(1,0)).size() == n);
  }
public:
  RandomUnreachable(int n, int k = 2) : Bit2Test(n,k){
    do{
      imps = Random(n,k).getImps();
    } while( reach0());
  }
};

int test_n[10] = {5,15,40,80,110,140,160,180,190,200};
int test_k[10] = {2,5,2,3,5,2,2,4,2,5};

char test_name[10][10] = {"bit21.in","bit22.in","bit23.in","bit24.in","bit25.in",
		      "bit26.in","bit27.in","bit28.in","bit29.in","bit210.in"};

int main(){
  unsigned int n,k;
  REP(test,10){
    n = test_n[test];
    k = test_k[test];
    vector<Bit2Test*> tests;
    REP(i,2) tests.push_back(new RandomPerms(n,k));
    REP(i,2) tests.push_back(new Cerny(n,k));
    REP(i,2) tests.push_back(new RandomUnreachable(n,k));
    REP(i,4) tests.push_back(new Random(n,k));
    random_shuffle(ALL(tests));
    REP(i,10){
      tests[i]->shuffleStates();
      tests[i]->shuffleImps();
    }
    
    ofstream of(test_name[test]);
    of << 10 << endl;
    REP(i,10){
      of << *(tests[i]);
      delete tests[i];
    }
    of.close();
  }
  return 0;
}
