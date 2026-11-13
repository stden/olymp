#include <cstdio>
#include <cstring>

#define maxn 1010
#define maxm 10010

int He1[maxn], He2[maxn], C1[maxn], C2[maxn], Ne[maxm], To[maxm], Pr[maxm], Is[maxm], X1[maxn], X2[maxn], Re[maxm];
int N1, N2, M, E = 0;

int dfs1( int u );
int dfs2( int u );

int dfs1( int u )
{
  C1[u] = 1;
  for (int t = He1[u]; t != -1; t = Ne[t])
    if (Is[t] && !Pr[t] && !C2[To[t]])
      if (dfs2(To[t]))
      {
        X1[u] = 1;
        Pr[t] = Pr[Re[t]] = 1;
        return 1;
      }
  return 0;
}

int dfs2( int u )
{
  C2[u] = 1;
  if (!X2[u])
  {
    X2[u] = 1;
    return 1;
  }
  for (int t = He2[u]; t != -1; t = Ne[t])
    if (Is[t] && Pr[t] && !C1[To[t]])
      if (dfs1(To[t]))
      {
        Pr[t] = Pr[Re[t]] = 0;
        return 1;
      }
  return 0;
}

int Pairs( void )
{
  memset(Pr, 0, sizeof(Pr));
  memset(X1, 0, sizeof(X1));
  memset(X2, 0, sizeof(X2));
  int u = 0, Ans = 0;
  while (1)
  {
    for (; u < N1 && X1[u]; u++)
      ;
    if (u == N1)
      break;
    memset(C1, 0, sizeof(C1));
    memset(C2, 0, sizeof(C2));
    if (dfs1(u++))
      Ans++;
  }
  return Ans;
}

int main( void )
{
  freopen("pairs.in", "rt", stdin);
  freopen("pairs.out", "wt", stdout);

  scanf("%d%d%d", &N1, &N2, &M);
  memset(He1, -1, sizeof(He1));
  memset(He2, -1, sizeof(He2));
  for (int i = 0; i < M; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    Ne[E] = He1[a - 1], To[E] = b - 1, Is[E] = 1, Re[E] = E + 1, He1[a - 1] = E++;
    Ne[E] = He2[b - 1], To[E] = a - 1, Is[E] = 1, Re[E] = E - 1, He2[b - 1] = E++;
  }

  int Res = Pairs(), Ans = 0;
  for (int i = 0; i < E; i += 2)
    for (int j = 0; j < i; j += 2)
    {
      Is[i] = Is[Re[i]] = 0;
      Is[j] = Is[Re[j]] = 0;
      if (Res != Pairs())
        Ans++;
      Is[i] = Is[Re[i]] = 1;
      Is[j] = Is[Re[j]] = 1;
    }

  printf("%d\n", Ans);

  return 0;
}
