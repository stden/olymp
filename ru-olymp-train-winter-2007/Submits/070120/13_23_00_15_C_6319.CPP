#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

//#define _DBG_

char rle[1048576];
__int64 len;

struct block
{
  __int64 a, b;
  int len;
  char c;
};
block str[65536];
int num;

struct kmp_block
{
  __int64 a, b;
  int len;
  __int64 first;
  int delta;
};
kmp_block kmp[1048576];
int nkmp;

void un_rle ()
{
  len = 0;
  num = 0;
  for (int i = 0; rle[i]; i++)
  {
    int count = 1;
    if (rle[i] >= '0' && rle[i] <= '9')
    {
      count = 0;
      while (rle[i] >= '0' && rle[i] <= '9')
        count = count * 10 + (rle[i] - '0'), i++;
    }
    if (num > 0 && str[num - 1].c == rle[i])
    {
      str[num - 1].b += count;
      str[num - 1].len += count;
    }
    else
    {
      str[num].a = len;
      str[num].b = len + count;
      str[num].len = count;
      str[num++].c = rle[i];
    }                     /*
    for (int j = 0; j < count; j++)
    {
      str[num].a = len + j;
      str[num].b = len + j + 1;
      str[num].len = 1;
      str[num++].c = rle[i];  
    }*/
    len += count;
  }
}

int bin_search (__int64 pos)
{
  int l = 0;
  int r = num;
  while (l < r)
  {
    int k = (l + r) / 2;
    if (pos >= str[k].b)
      l = k + 1;
    else if (pos < str[k].a)
      r = k - 1;
    else
      return k;
  }
  return l;
}
int ans_bin_search (__int64 pos)
{
  int l = 0;
  int r = nkmp;
  while (l < r)
  {
    int k = (l + r) / 2;
    if (pos >= kmp[k].b)
      l = k + 1;
    else if (pos < kmp[k].a)
      r = k - 1;
    else
      return k;
  }
  return l;
}

void start_block (__int64 a, __int64 first, bool delta)
{
  kmp[nkmp].a = a;
  kmp[nkmp].first = first;
  kmp[nkmp++].delta = delta ? 1 : 0;
}
void end_block (__int64 b)
{
  if (b == kmp[nkmp - 1].a)
  {
    nkmp--;
    return;
  }
  kmp[nkmp - 1].b = b;
  kmp[nkmp - 1].len = int (b - kmp[nkmp - 1].a);
}

#define EVENT_CURSOR 0
#define EVENT_IMAGE  1
const __int64 INF = 1000000000 * 1000000000;
struct event
{
  int type;
  __int64 time;
};
event events[2];
void add_event (int type, __int64 time)
{
  events[type].type = type;
  events[type].time = time;
}
void remove_event (int type)
{
  events[type].time = INF;
}
event next_event ()
{
  if (events[0].time < events[1].time)
    return events[0];
  else
    return events[1];
}

__int64 get_answer (__int64 a)
{
  if (a == 0) return 0;
  int i = ans_bin_search (a);
  return kmp[i].first + (a - kmp[i].a) * kmp[i].delta; 
}

void run_kmp ()
{
  nkmp = 0;
  int cur_c = 0, cur_i = 0;
  __int64 pos_c = 1, pos_i = 0;
  while (pos_c >= str[cur_c].b)
    cur_c++;
  char c_c = str[cur_c].c;
  char c_i = str[cur_i].c;
  int i_vel;
  if (c_c == c_i)
  {
    start_block (pos_c, pos_i + 1, 1);
    i_vel = 1;
  }
  else
  {
    start_block (pos_c, 0, 0);
    i_vel = 0;
  }
  __int64 time = 0;
  add_event (EVENT_CURSOR, str[cur_c].b - pos_c + time);
  add_event (EVENT_IMAGE, str[cur_i].b - pos_i + time);
  while (pos_c < len)
  {
    event e = next_event ();
    __int64 delta = e.time - time;
    time = e.time;
    pos_c += delta;
    pos_i += delta * i_vel;
    while (pos_i >= str[cur_i].b)
      cur_i++;
    while (pos_c >= str[cur_c].b)
      cur_c++;
    char c_c = str[cur_c].c;
    char c_i = str[cur_i].c;
    if (pos_c >= len)
      break;
    end_block (pos_c);
#ifdef _DBG_
    printf ("$%I64d (%d) %I64d (%d)\n", pos_i, cur_i, pos_c, cur_c);
#endif
    while (c_c != c_i && pos_i > 0)
    {
#ifdef _DBG_
      printf ("!jump from %I64d", pos_i - 1);
#endif
      __int64 pp = pos_i;
      pos_i = get_answer (pos_i - 1);
      int pcur_i = cur_i;
      cur_i = bin_search (pos_i);
      if (cur_i == pcur_i)
      {
        __int64 delta = pp - pos_i;
        __int64 left = pos_i - str[cur_i].a;
        left /= delta;
        pos_i -= left * delta;
      }
      c_i = str[cur_i].c;
#ifdef _DBG_
      printf (" to %I64d (%d)\n", pos_i, cur_i);
#endif
    }
    if (c_c == c_i)
    {
      start_block (pos_c, pos_i + 1, 1);
      i_vel = 1;
    }
    else
    {
      start_block (pos_c, 0, 0);
      i_vel = 0;
    }
    add_event (EVENT_CURSOR, str[cur_c].b - pos_c + time);
    add_event (EVENT_IMAGE, str[cur_i].b - pos_i + time);
  }
  end_block (len);
}

int main ()
{
  freopen ("rle.in", "rt", stdin);
  freopen ("rle.out", "wt", stdout);

  scanf ("%s", rle);
  un_rle ();
#ifdef _DBG_
  for (int i = 0; i < num; i++)
    printf ("%c %I64d-%I64d (%d)\n", str[i].c, str[i].a, str[i].b, str[i].len);
#endif
  
  run_kmp ();

#ifdef _DBG_
  printf ("!\n");
  for (int i = 0; i < nkmp; i++)
    printf ("%I64d %d %I64d-%I64d (%d)\n", kmp[i].first, kmp[i].delta, kmp[i].a, kmp[i].b, kmp[i].len);
#endif
  int n;
  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
  {
    __int64 a;
    scanf ("%I64d", &a);
    printf ("%I64d\n", get_answer (a - 1));
//    printf ("%d\n", bin_search (a - 1));
  }

  return 0;
}
