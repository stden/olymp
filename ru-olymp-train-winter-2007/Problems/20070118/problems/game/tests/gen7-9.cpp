#include <fstream>
#include <cstdlib>
#include <ctime>
using namespace std;

const int BEGTEST = 7;
const int ENDTEST = 9;
const int ns[5] = {3, 8, 15};


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
			out << "1 ";
		}
		out << "\n";
	}
	for (i = 0; i < n; i++)
	{
		for (j = 0; j < n; j++)
		{
			out << "0.01 ";
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