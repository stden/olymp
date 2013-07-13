#include <cstdio>
#include <cstring>

#define maxn 1010
#define maxm 10010

int He1[maxn], He2[maxn], C1[maxn], C2[maxn], Ne[maxm], To[maxm], Pr[maxm], Is[maxm], X1[maxn], X2[maxn], Re[maxm];
int TrueX1[maxn], TrueX2[maxn], TruePr[maxm];
int TempX1[maxn], TempX2[maxn], TempPr[maxm];
int N1, N2, M, E = 0;

int dfs1( int u, int f );
int dfs2( int u, int f );

int dfs1( int u, int f )
{
  C1[u] = 1;
  if (f && !X1[u])
  {
    X1[u] = 1;
    return 1;
  }
  for (int t = He1[u]; t != -1; t = Ne[t])
    if (Is[t] && ((!Pr[t]) ^ f) && !C2[To[t]])
      if (dfs2(To[t], !f))
      {
        X1[u] = 1;
        Pr[t] = Pr[Re[t]] = !f;
        return 1;
      }
  return 0;
}

int dfs2( int u, int f )
{
  C2[u] = 1;
  if (f && !X2[u])
  {
    X2[u] = 1;
    return 1;
  }
  for (int t = He2[u]; t != -1; t = Ne[t])
    if (Is[t] && ((!Pr[t]) ^ f) && !C1[To[t]])
      if (dfs1(To[t], !f))
      {
        X2[u] = 1;
        Pr[t] = Pr[Re[t]] = !f;
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
    if (dfs1(u++, 0))
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

//*/
  int Res = Pairs(), Ans = 0;
  memcpy(TrueX1, X1, sizeof(X1));
  memcpy(TrueX2, X2, sizeof(X2));
  memcpy(TruePr, Pr, sizeof(Pr));
  for (int i = 0; i < E; i += 2)
  {
    memcpy(X1, TrueX1, sizeof(X1));
    memcpy(X2, TrueX2, sizeof(X2));
    memcpy(Pr, TruePr, sizeof(Pr));
    int f = 1;
    if (Pr[i])
    {
      Pr[i] = Pr[Re[i]]= 0;
      X2[To[i]] = X1[To[Re[i]]] = 0;
      f = 0;
    }
    Is[i] = Is[Re[i]] = 0;
    memset(C1, 0, sizeof(C1));
    memset(C2, 0, sizeof(C2));
    if (f || dfs1(To[Re[i]], 0) || dfs2(To[i], 0))
    {
      memcpy(TempX1, X1, sizeof(X1));
      memcpy(TempX2, X2, sizeof(X2));
      memcpy(TempPr, Pr, sizeof(Pr));
      for (int j = 0; j < i; j += 2)
      {
        memcpy(X1, TempX1, sizeof(X1));
        memcpy(X2, TempX2, sizeof(X2));
        memcpy(Pr, TempPr, sizeof(Pr));
        int g = 1;
        if (Pr[j])
        {
          Pr[j] = Pr[Re[j]]= 0;
          X2[To[j]] = X1[To[Re[j]]] = 0;
          g = 0;
        }
        Is[j] = Is[Re[j]] = 0;
        memset(C1, 0, sizeof(C1));
        memset(C2, 0, sizeof(C2));
        if (!(g || dfs1(To[Re[j]], 0) || dfs2(To[j], 0)))
          Ans++;
        Is[j] = Is[Re[j]] = 1;
      }
    }
    else
      Ans += i / 2;
    Is[i] = Is[Re[i]] = 1;
  }
/*/
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
/*/

  printf("%d\n", Ans);

  return 0;
}
