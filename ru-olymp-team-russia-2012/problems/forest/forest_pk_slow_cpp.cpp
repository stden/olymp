#include <iostream>
#include <fstream>
using namespace std;

int a[100][100], newA[100][100];

int main() {
	freopen("forest.in", "r", stdin);
	freopen("forest.out", "w", stdout);
	int n, m;
	cin >> n;
	cin >> m;
	for (int i = 0; i < n; i++)
		for (int j = 0; j < m; j++)
			cin >> a[i][j];
	bool fl = true;
	int ans = 0;
	while (fl) {
		fl = false;
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < m; j++) {
				newA[i][j] = a[i][j];
				if ((i - 1 >= 0) && (a[i - 1][j] == a[i][j] + 1)) {
					newA[i][j] = a[i][j] + 1;
				}
				if (i + 1 < n && (a[i + 1][j] == a[i][j] + 1)) {
					newA[i][j] = a[i][j] + 1;
				}
				if (j - 1 >= 0 && a[i][j - 1] == a[i][j] + 1) {
					newA[i][j] = a[i][j] + 1;
				}
				if (j + 1 < m && a[i][j + 1] == a[i][j] + 1) {
					newA[i][j] = a[i][j] + 1;
				}
				if (newA[i][j] == a[i][j] + 1)
					fl = true;
			}
		}
		for (int i = 0; i < n; i++)
			for (int j = 0; j < m; j++)
				a[i][j] = newA[i][j];
		ans++;
	}
	cout << ans - 1 << "\n";
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			cout << a[i][j];
			if (j < m - 1)
				cout << ' ';
		}
		cout << "\n";
	}
}
		