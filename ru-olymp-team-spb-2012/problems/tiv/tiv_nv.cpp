#include <cstdio>
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <assert.h>

using namespace std;

const int MAX_ALPHA = 11;
const int MAX_LENGHT = 9;
const int MAX_COUNT = 10;

int a[MAX_ALPHA][MAX_ALPHA];

enum color {WHITE, GREY, BLACK};
vector<color> colors;
vector<bool> used;
vector<int> ans;

void init()
{
	for (int i = 0; i < MAX_ALPHA; i++)
		for (int j = 0; j < MAX_ALPHA; j++)
			a[i][j] = 0;
	colors.assign(MAX_ALPHA, WHITE);
	used.assign(MAX_ALPHA, false);
}

void check(string s)
{
	assert(1 <= s.length());
	assert(s.length() <= MAX_LENGHT);
	for (int i = 0; i < s.length(); i++)
		assert('a' <= s[i] && s[i] < (char)('a' + 10));
};

bool is_cycle(int v)
{
	colors[v] = GREY;
	for (int u = 0; u < MAX_ALPHA; u++)
	{
		if (!a[v][u]) continue;
		switch (colors[u])
		{
			case WHITE: if (is_cycle(u)) return true; break;
			case GREY: return true; break;
			default:	break;
		}
	};
	colors[v] = BLACK;
	return false;
};

void dfs(int v)
{
	used[v] = true;
	for (int u = 0; u < MAX_ALPHA; u++)
	{
		if (a[v][u] == 0) continue;
		if (!used[u]) dfs(u);
	}
	ans.push_back(v);
};

void topsort()
{
	ans.clear();
	for (int i = 0; i < MAX_ALPHA; i++)
		if (!used[i]) dfs(i);
	reverse(ans.begin(), ans.end());
};

int main()
{
	freopen("tiv.in", "r", stdin);
	freopen("tiv.out", "w", stdout);
	
	init();
	int n;
	cin >> n;
	assert(1 <= n && n <= MAX_COUNT);

	vector<string> num(n);
	for (int i = 0; i < n; i++)
	{
		cin >> num[i];
		check(num[i]);
	}

	for (int i = 0; i < n; i++)
		if (num[i].size() != 1) a[0][num[i][0] - 'a' + 1] = 1;

	for (int i = 1; i < n; i++)
	{
		if (num[i - 1] == num[i] || num[i].length() < num[i - 1].length())
		{
			cout << "No\n";
			return 0;
		}
        if (num[i - 1].length() != num[i].length()) continue;
		for (int j = 0; j < num[i].length(); j++)
			if (num[i][j] != num[i - 1][j])
			{
				int from = num[i - 1][j] - 'a' + 1;
				int to = num[i][j] - 'a' + 1;
				a[from][to] = 1;
				break;
			}
	}

	for (int i = 0; i < MAX_ALPHA; i++)
		if (colors[i] == WHITE) 
			if (is_cycle(i))
			{
				cout << "No\n";
				return 0;
			}

	topsort();
	vector<pair<int, int> > top(MAX_ALPHA);
	for (int i = 0; i < MAX_ALPHA; i++)
		top[i] = make_pair(ans[i], i);
	
	sort(top.begin(), top.end());
	if (top[0].second == 0)
	{
		cout << "No\n";
		return 0;
	}
    cout << "Yes\n";
	for (int i = 1; i < top.size(); i++)
		cout << ((top[i].second < top[0].second) ? top[i].second : top[i].second - 1) << ((i == top.size() - 1) ? "\n" : " ");

	return 0;
}
