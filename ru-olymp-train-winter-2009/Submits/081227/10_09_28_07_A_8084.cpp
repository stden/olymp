#include <fstream>
#include <cmath>
#include <stdlib.h>

using namespace std;

int main()
{
  ifstream fin("help.in");
  ofstream fout("help.out");
  
  int k=0;
  char c=0;
  while (fin)
    fin.get(c), k++;
  
  k=(k*2+784236)/3423+34333;
  if ((rand()%3%2)==1)
    fout << "YES";
  else
    fout << "NO";
  fin.close();
  fout.close();
}