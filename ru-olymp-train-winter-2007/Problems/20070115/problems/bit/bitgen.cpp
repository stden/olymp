#include <vector>
#include <iostream>
#include <fstream>

using namespace std;

class TestGenIO{
protected:
  int n;
  vector<char> pattern;
public:
  TestGenIO(int _n) : n(_n){
    pattern.resize(n+1000);
  };
  
  friend ostream& operator<<(ostream &os, const TestGenIO &data){
    os << data.n << endl; 
    for (int i=0 ; i<data.n ; i++)
      os << data.pattern[i];
    return os << endl;
  };
};


class TestGen : public TestGenIO{
public:
  TestGen(int _n) : TestGenIO(_n){
    int i=0;
    while (i<n){
      char c = lrand48()%3 + 'a';
      int d = lrand48()%4 + 2;
      for (int j=0 ; j<d ; j++)
	pattern[i++] = c;
    }
  };
};

class TestGenNo : public TestGenIO{
public:
  TestGenNo(int _n) : TestGenIO(_n){
    int i=0;
    while (i<n){
      char c = lrand48()%3 + 'a';
      pattern[i++] = c;
      pattern[i++] = c;
      pattern[i++] = c;
    }
  };
};

class TestsGen{
public:
  TestsGen(ostream &os, int n, int length){
    os << n << endl;
    for (int i=0 ; i<n ; i++){      
      if (drand48()<0.5)
	os << TestGen(length);
      else
	os << TestGenNo(length);
    };
  };
};

int main(){
  {
    srand48(12345678);
    ofstream ofs("bit2.in");
    TestsGen(ofs, 10, 10);
  }
  {
    srand48(12345);
    ofstream ofs("bit3.in");
    TestsGen(ofs, 10, 100);
  }
  {
    srand48(12345678);
    ofstream ofs("bit4.in");
    TestsGen(ofs, 10, 500);
  }
  {
    srand48(1234567);
    ofstream ofs("bit5.in");
    TestsGen(ofs, 10, 1000);
  }
  {
    srand48(12345678);
    ofstream ofs("bit6.in");
    TestsGen(ofs, 10, 5000);
  }
  {
    srand48(123456);
    ofstream ofs("bit7.in");
    TestsGen(ofs, 10, 10000);
  }
  {
    srand48(12345678);
    ofstream ofs("bit8.in");
    TestsGen(ofs, 10, 20000);
  }
  {
    srand48(12345678);
    ofstream ofs("bit9.in");
    TestsGen(ofs, 10, 50000);
  }
  {
    srand48(12345);
    ofstream ofs("bit10.in");
    TestsGen(ofs, 10, 100000);
  }
};

