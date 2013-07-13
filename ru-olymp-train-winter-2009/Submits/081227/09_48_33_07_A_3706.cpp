#include <fstream>

using namespace std;

const string namesout[30]= {"next.out", "half.out", "digitsum.out", "help.out", "calls.out", "apache.out", "stress.out", "btrees.out", "palin.out", "dynarray.out", "tts.out", "marked.out", "marked2.out", "marked3.out", "salesman.out", "path.out", "modsum.out", "modsum2.out", "modsum3.out",  "cube.out", "sum.out", "cuts.out", "room.out", "code.out", "armor.out", "multiplexor.out", "division.out", "chess.out","aplusminusb.out", "baiocchi.out"};

int main()
{
  ifstream fin("help.in");
  ofstream fout("help.out");
  
  while (fin)
  {
    string str="";
    while  (fin)
    {
      if ((str=="assign(output,")  || (str=="rewrite(output,"))
	break;
      else
	fin >> str;
    }
    
    if (!fin)
    {
      fout << "YES";
      return 0;
    }
    fin >> str;
    for (int i=0; i<30; i++)
    {
      bool f = true;
      for (int j=0; j<namesout[i].length() && f && (j+1)<str.length(); j++)
	if (str[j+1]!=namesout[i][j])
	  f=false;
      if (f)
      {
	fout << "NO";
	return 0;
      }
    }
    
      int i=1;
      while (str[i]!='.' && i<str.length())
	i++;
      if (str[i-1]=='t' && str[i-2]=='u' && str[i-2]=='o')
          fout << "NO";
      else
	  fout << "YES";
      return 0;
  }
  
}