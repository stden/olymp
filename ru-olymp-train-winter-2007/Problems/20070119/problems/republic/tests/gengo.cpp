#include <fstream>
using namespace std;


int main()
{
	ofstream out("doall.cmd");
	ofstream out1("wipeall.cmd");
	int i;
	for (i = 2; i <= 26; i++)
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
		out << "copy " << name << " republic.in\n";
		out << "solution.exe\n";
		out << "copy republic.out " << name << ".a\n";
		out1 << "del " << name << "\n";
	}
	return 0;
}