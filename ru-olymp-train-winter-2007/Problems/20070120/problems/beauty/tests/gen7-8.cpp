#include <fstream>
#include <set>
#include <vector>
#include <string>
#include <ctime>
using namespace std;

const int seeds [15] =
{
1169280420,
1169280456
};        

const int BEGTEST = 7;
const int ENDTEST = 8;

const int MAXLEN = 10000;
const int MAXN = 100;
const int MINN = 100;
const int MAXSLEN = 20;
const int MINSLEN = 6;
const int LETTERS = 3;

int GetRand()
{
	int a = rand() * 32768 + rand();
	if (a < 0) a = -a;
	return a;
}

vector<string> ss;
set <string> sss;

void GenTest(ostream &out)
{
	int len = GetRand() % MAXLEN + 1;
	ss.clear();
	while (len != 0)
	{
		int clen = GetRand() % (MAXSLEN - MINSLEN + 1) + MINSLEN;
		if (clen > len) break;
		string cs = "";
		int j;
		for (j = 0; j < clen; j++)
		{
			char c = (char)(GetRand() % LETTERS + 'a');
			cs += c;
		}
		if (sss.find(cs) != sss.end()) continue;
		sss.insert(cs);
		ss.push_back(cs);
		len -= clen;
	}
	out << ss.size() << "\n";
	int i;
	for (i = 0; i < ss.size(); i++)
	{
		out << ss[i] << " ";
		out << GetRand() % 2000000000 + 1 << "\n";
	}
	int n = rand() % (MAXN - MINN + 1) + MINN;
	out << n;
}



int main()
{
    unsigned seed = (unsigned)time(NULL);
	srand(seed);
	int i;
	for (i = BEGTEST; i <= ENDTEST; i++)
	{
		srand(seeds[i - BEGTEST]);
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