#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <assert.h>

using namespace std;

#define TASKNAME "digitsum"

const char mvto[][50] = {
  "11212112121121212112121121212",
  "11212112121121212112121121212112121121212"
};
int mvtol[2];
int countall[2][2];
int countto[2][2][50];

vector<bool> sm2(30000000);

void calc_const() {
  memset(countto, 0, sizeof countto);
  for (int ty = 0; ty < 2; ty++) {
    mvtol[ty] = strlen(mvto[ty]);
    
    countall[ty][0] = countall[ty][1] = 0;
    switch (mvto[ty][0]) {
      case '1':countall[ty][0] = 1; countto[ty][0][0] = 1; break;
      case '2':countall[ty][1] = 1; countto[ty][1][0] = 1; break;      
    }
    for (int i = 1; i < mvtol[ty]; i++)
      switch (mvto[ty][i]) {
	case '1':countall[ty][0]++;
	  countto[ty][0][i] = countto[ty][0][i - 1] + 1;
	  countto[ty][1][i] = countto[ty][1][i - 1];
	  break;
	case '2':countall[ty][1]++;
	  countto[ty][0][i] = countto[ty][0][i - 1];
	  countto[ty][1][i] = countto[ty][1][i - 1] + 1;
	  break;
      }
  }
}

void calc_sm2() {
  sm2[0] = 0;
  int l = 1;
  for (int steps = 1; steps < 5; steps++) {
    int nl = 0;
    for (int i = 0; i < l; i++) {
      int tmp = sm2[i];
      for (int i2 = 0; i2 < mvtol[tmp]; i2++)
	sm2[nl++] = !!(mvto[tmp][i2] - '1');
    }
    l = nl;
  }
}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  calc_const(); calc_sm2();
  
  int n; scanf("%d", &n);
  set<int> bords; vector< pair<int, int> > reqs(n);
  for (int i = 0; i < n; i++) {
    int l, r; scanf("%d %d", &l, &r); l--, r--;
    bords.insert(l - 1);
    bords.insert(r);
    reqs[i] = make_pair(l, r);
  }    
   
  map<int, int> ress;    
  int cto = 0, b_cto = 0;
  int cur_res = 0;
  while (!bords.empty()) {
    int next = *(bords.begin());
    bords.erase(bords.begin());
    if (next < 0) {ress.insert(make_pair(next, 0)); continue;}
    
    while (b_cto + mvtol[sm2[cto]] <= next) {
      cur_res += countall[sm2[cto]][0]
              + (countall[sm2[cto]][1] << 1);
      b_cto += mvtol[sm2[cto]];
      cto++;
    }
    int off_in = next - b_cto;
    //fprintf(stderr, "%d: %d*... + %d -> ", next, cto, off_in);
    int ans2 = countto[sm2[cto]][0][off_in] + (countto[sm2[cto]][1][off_in] << 1);
    //fprintf(stderr, "%d + %d = %d\n", cur_res, ans2, cur_res + ans2);
    ress.insert(make_pair(next, cur_res + ans2));
  }
  
  for (int i = 0; i < n; i++)
    printf("%d\n", ress[reqs[i].second] - ress[reqs[i].first - 1]);
  return 0;
}