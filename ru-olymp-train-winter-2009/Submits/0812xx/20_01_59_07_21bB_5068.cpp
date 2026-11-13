#include <fstream>
#include <cmath>

using namespace std;

int main()
{
  ifstream fin("stress.in");
  ofstream fout("stress.out");
  
  int max1=-1, max2=-1, maxr1, maxr2;
  
  while (fin)
  {
    string str="";
    bool f =false;
    while (fin && !f)
    {
      if (str=="randseed")
	f=true;
      fin >> str;
    }
    
    if (!f)
      break;
    
    int randseed;
    
    fin >> randseed;
    
    
     str="";
    f =false;
    while (fin && !f)
    {
      if (str=="Work")
	f=true;
      else
	fin >> str;
    }
    
    fin >> str;
    
    double x1;
    int t1=0;
    
    char c=0;
    fin.get(c);
    fin.get(c);
    while (c!=',')
      t1=t1*10+int(c)-int('0'), fin.get(c);
      
    str="";
     f =false;
    while (fin && !f)
    {
      if (str=="Work")
	f=true;
      else
	fin >> str;
    }
 
    
    
    fin >> str;
    
    double x2;
    int t2=0;
    
     c=0;
    
    fin.get(c);
    fin.get(c);
    while (c!=',')
      t2=t2*10+int(c)-int('0'), fin.get(c);
    
    if (t1>max1)
      max1=t1, maxr1=randseed;
    
    if (t2>max2)
      max2=t2, maxr2=randseed;
    
    fout << "At randseed = " << randseed << '\n';
    fout << "First: " << t1 << " ms" << '\n';
      fout << "Second: " << t2 << " ms" << '\n';
  }
  
  fout << "Maximal work time for first: " << max1 << " at randseed = " << maxr1 << '\n';
  fout << "Maximal work time for second: " << max2 << " at randseed = " << maxr2 << '\n';
}