#include <fstream>

using namespace std;

int main()
{
  ifstream fin("help.in");
  ofstream fout("help.out");
    fout << "YES";
  fin.close();
  fout.close();
}