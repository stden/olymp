#include <iostream>
#include <cstdio>
#include <algorithm>
#include <vector>
#include <string>

using namespace std;

const int MAX_STEP = 3628800; // 10!

int main()
{
	freopen("tiv.in", "r", stdin);
	freopen("tiv.out", "w", stdout);
	int n;
	cin >> n;
	vector<string> num(n);
	vector<int> ch(n);
	
	for (int i = 0; i < n; i++)
		cin >> num[i];

	vector<int> ans(10);
	for (int i = 0; i < 10; i++)
		ans[i] = i;

	for (int it = 0; it < MAX_STEP; it++)
	{
		bool f = true;

		for (int i = 0; i < n; i++)
		{
			if (num[i].length() != 0)
				if (ans[num[i][0] - 'a'] == 0)
				{
					f = false;
					break;
				}		
			for (int j = 0; j < num[i].size(); j++)
				ch[i] = ch[i] * 10 +  ans[num[i][j] - 'a'];
		}
		
		for (int i = 1; i < n; i++)
			if (ch[i - 1] >= ch[i]) f = false;
		
		if (f)
		{
            cout << "Yes\n";
			for (int i = 0 ; i < ans.size(); i++)
				cout << ans[i] << ((i == ans.size() - 1) ? "\n" : " ");
			return 0;
		};

		next_permutation(ans.begin(), ans.end());
	}
	cout << "No\n";
	return 0;
}
