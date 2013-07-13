#include <fstream>
using namespace std;


int main()
{
	ofstream out("doall.bat");
	ofstream out1("wipeall.bat");
	int i;
	for (i = 1; i <= 50; i++)
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
		out << "copy " << name << " restore.in\n";
		out << "solution.exe\n";
		out << "copy restore.out " << name << ".a\n";
		out1 << "del " << name << "\n";
	}
	return 0;
}