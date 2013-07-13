#include <iostream>
#include <fstream>
#include <cmath>
#include <cstdlib>
#include <map>
#include <set>
#include <vector>
#include <cstring>
#include <string>
#include <algorithm>
#include <queue>

using namespace std;

const int nmax = 3e3;

int a[nmax][nmax];
int n,m;

int dx[] = { -1, 1, 0, 0, 0 };
int dy[] = { 0, 0, -1, 1, 0 };

bool valid(int x, int y) {
	return (0 <= x && x < n && 0 <= y && y < m); 
}

vector < pair<int,int> > interesting;

int main()
{
	freopen("forest.in", "r", stdin);
	freopen("forest.out", "w", stdout);
	scanf("%d %d", &n, &m);
	for (int i = 0; i < n; i ++) 
		for (int j = 0; j < m; j ++)
			scanf("%d", &a[i][j]);
	for (int i = 0; i < n; i ++)
		for (int j = 0; j < m; j ++) {
			bool ok = false;
			for (int k = 0; k < 4; k ++)
			{
				int i1 = i + dx[k];
				int j1 = j + dy[k];
				if (valid(i1, j1) && a[i][j] + 1 == a[i1][j1]) {
					ok = true;
				}
			}
			if (ok) {
				interesting.push_back(make_pair(i, j));
			}
		}
	int step = 0;
	while (interesting.size() > 0) {
		vector < pair <int, int> > new_interesting;
		for (int i = 0; i < interesting.size(); i ++)
			a[interesting[i].first][interesting[i].second] ++;
		for (int i = 0; i < interesting.size(); i ++) 
			for (int k = 0; k < 5; k ++) {
				int i1 = interesting[i].first + dx[k];
				int j1 = interesting[i].second + dy[k];
				if (valid(i1, j1)) {
					bool ok = false;
					for (int t = 0; t < 4; t ++) {
						int i2 = i1 + dx[t];
						int j2 = j1 + dy[t];
						if (valid(i2, j2) && a[i1][j1] + 1 == a[i2][j2]) {
							ok = true;
						}
					}
					if (ok) {
						new_interesting.push_back(make_pair(i1, j1));
					}
				}
			}
		sort(new_interesting.begin(), new_interesting.end());
		new_interesting.resize(unique(new_interesting.begin(), new_interesting.end()) - new_interesting.begin());
		interesting.swap(new_interesting);
		step ++;
	}
	printf("%d\n", step);
	for (int i = 0; i < n; i ++) {
		for (int j = 0; j < m; j ++) {
			printf("%d%c", a[i][j], (j + 1 == m) ? '\n' : ' ');
		}
	}
	return 0;
}
