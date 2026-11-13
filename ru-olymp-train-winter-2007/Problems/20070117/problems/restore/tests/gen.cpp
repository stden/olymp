#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int MAXLEN = 50;

int GetRand()
{
	int a = rand() * 1000 + rand();
	if (a < 0) a = -a;
	return a;
}

int main()
{
	srand((unsigned)time(NULL));
	ofstream out("restore.in");
	int n, m;
	n = 50;
	int i, j;
	m = rand() % 1000 + 1;
	out << n << " " << m << " 239017\n"; 
	for (i = 1; i <= m; i++)
	{
		int  p, q;
		p = rand() % n + 1;
		q = rand() % n + 1;
		out << p << " " << q << "\n";
	}
	out << rand() % n + 1 << "\n";
	int ns = MAXLEN;
	out << ns << "\n";
	int wd = 0;
	for (i = 1; i <= ns; i++)
	{
		if (wd == 0) wd = 1;
		else
		{
			if (rand() % 2 == 0) wd++;
			else wd--;
		}
		out << wd << " " << GetRand() % 1000000000 + 1 << "\n";
	}
	return 0;
}