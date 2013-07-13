#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int BEGTEST = 21;
const int ENDTEST = 26;
const int ns[6] = {15, 14, 13, 14, 15, 15};
const long double MINPROB = 0.001;

int GetRandom()
{
	int a = rand() * 10000 + rand();
	if (a < 0) a = -a;
	return a;
}

inline void Swap(int &a, int &b)
{
	int t = a;
	a = b;
	b = t;
}

int curtest = 0;

void GenTest(ofstream& out)
{
	int n = ns[curtest];
	curtest++;
	int i, j;
	out << n << "\n";
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			int k = GetRandom() % 1000;
			if (k == 0) k = 1;
			out << k << " ";
		}
		out << "\n";
	}
	out.setf(ios::fixed | ios::showpoint);
	out.precision(3);
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			int ir = GetRandom() % 10000;
			long double r = ir;
			long double r1 = GetRandom() % ir + 1;
			r = r1 / r;
			if (r < MINPROB) r = MINPROB; 
			out << r << " ";
		}
		out << "\n";
	}
}

int main()
{
	srand(17565);
    int i;
	for (i = BEGTEST; i <= ENDTEST; i++)
	{
		char num[100];
		char name[100];
		itoa(i, num, 10);
		if (strlen(num) < 2)
		{
			strcpy(name, "0");
		}
		else strcpy(name, "");
		strcat(name, num);
		ofstream out(name);
		GenTest(out);
		out.close();
	}
	return 0;
}