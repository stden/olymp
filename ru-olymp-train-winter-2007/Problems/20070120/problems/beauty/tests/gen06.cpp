#include <fstream>
#include <vector>
#include <string>
#include <ctime>
using namespace std;

int GetRand()
{
	int a = rand() * 32768 + rand();
	if (a < 0) a = -a;
	return a;
}

vector<string> ss;

void GenTest(ostream &out)
{
	int len = 0;
	string curs = "";
	int i;
	while (len < 10000)
	{
		curs += 'a';
		len += curs.length();
		if (len > 10000) break;
		ss.push_back(curs);
	}
	out << ss.size() << "\n";
	for (i = 0; i < ss.size(); i++)
	{
		out << ss[i] << " " << GetRand() % 100000000 + 990000000 << "\n";
	}
	out << "100\n";
}

int main()
{
	srand(19258);
	ofstream out;
	out.open("06");
	GenTest(out);
	return 0;
}