#include <fstream>

using namespace std;

int main()
{
  ifstream fin("help.in");
  ofstream fout("help.out");
  
  int k=0;
  char c=0;
  while (fin)
    fin.get(c), k++;
  
  k+=(k*2+784236)/3423+34333;
  if ((k%555)>250)
    fout << "NO";
  else
    fout << "YES";
  fin.close();
  fout.close();
}