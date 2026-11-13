#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>
#include <list>
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
    typeof(sm2.begin()) nptr = sm2.begin();
    typeof(sm2.begin()) ptr = sm2.begin();
    for (int i = 0; i < l; i++, ptr++) {
      int tmp = *ptr;
      for (int i2 = 0; i2 < mvtol[tmp]; i2++)
	*(nptr++) = !!(mvto[tmp][i2] - '1');
      nl += mvtol[tmp];
    }
    l = nl;
  }
}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  calc_const(); calc_sm2();
  
  int n; scanf("%d", &n);
  vector<int> bords(n << 1); vector< pair<int, int> > reqs(n);
  for (int i = 0; i < n; i++) {
    int l, r; scanf("%d %d", &l, &r); l--, r--;
    bords.push_back(l - 1);
    bords.push_back(r);
    reqs[i] = make_pair(l, r);
  }
  sort(bords.begin(), bords.end());
   
  map<int, int> ress;    
  typeof(sm2.begin()) cto_ptr = sm2.begin();
  int cur_begin = 0;
  int b_cto = 0;
  int cur_res = 0;
  while (cur_begin < bords.size()) {
    int next = bords[cur_begin++];
    if (next < 0) {ress.insert(make_pair(next, 0)); continue;}
    
    while (b_cto + mvtol[*cto_ptr] <= next) {
      cur_res += countall[*cto_ptr][0]
              + (countall[*cto_ptr][1] << 1);
      b_cto += mvtol[*cto_ptr];
      cto_ptr++;
    }
    int off_in = next - b_cto;
    //fprintf(stderr, "%d: %d*... + %d -> ", next, cto, off_in);
    int ans2 = countto[*cto_ptr][0][off_in] + (countto[*cto_ptr][1][off_in] << 1);
    //fprintf(stderr, "%d + %d = %d\n", cur_res, ans2, cur_res + ans2);
    ress.insert(make_pair(next, cur_res + ans2));
  }
  
  for (int i = 0; i < n; i++)
    printf("%d\n", ress[reqs[i].second] - ress[reqs[i].first - 1]);
  return 0;
}