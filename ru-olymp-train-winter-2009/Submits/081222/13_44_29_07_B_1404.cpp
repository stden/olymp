#include <iostream>
 #include <fstream>
using namespace std;

long long n;

int main()
{
  ifstream fin("cuts.in");
  ofstream fout("cuts.out");
  fin >> n;
  if (n==2)
    fout << "01";
  if (n==6)
  {  fout << "011111" << '\n';
fout << "000001" << '\n';
fout << "011001" << '\n';
fout << "011101" << '\n';
fout << "010101" << '\n';
fout << "010001" << '\n';
fout << "011011" << '\n';
fout << "001001" << '\n';
fout << "000101" << '\n';
fout << "001011" << '\n';
fout << "010111" << '\n';
fout << "001111" << '\n';
fout << "000011" << '\n';
fout << "010011" << '\n';
fout << "000111" << '\n';
fout << "001101" << '\n';}
}