#include "treeunit.h"
#include <iostream>

using namespace std;


struct edge
{
  int x, v, num;
  edge* next, * rev, *prev;
};

edge* E[2000010];
int count[200010];
edge* numofp[200010];
edge* neededvert=0;
int root=-1, n;
int p[200010];

int abs(int x)
{
  return (x<0? -x: x);
}
void del(edge* vert)
{
  if (!vert->prev)
    {
      E[vert->x]=vert->next;
      if (vert->next)
	vert->next->prev =0;
    }
  else
  {	
    vert->prev->next=vert->next;
      if (vert->next)
	vert->next->prev =0;
  }
}

void addedge(int x,int  y, int num)
{

  edge* temp = new edge ;
  edge* temp2 = new edge  ;
  temp->v=y;
  temp->x=x;
  temp->next=E[x];
  if (E[x])
    E[x]->prev=temp;
  temp->num=num;
  temp->rev = temp2;
  temp->prev=0;
  E[x]=temp;
  temp2->v=x;
  temp2->x=y;
  temp2->next=E[y];
  if (E[y])
     E[y]->prev=temp2;
  temp2->num=num;
  temp2->rev = temp;
  temp2->prev=0;
  E[y]=temp2;
  count[x]++;	count[y]++;
}

void dfs1(int x)
{
  edge* vert;
  count[x]=1;
  for (vert=E[x]; vert; vert=vert->next)
    if (p[x]!=vert->v)
    {
      p[vert->v]=x;
      numofp[vert->v]=vert;
      dfs1(vert->v);
      count[x]+=count[vert->v];
    }
}

void dfs2(int x)
{
  edge* vert;
  for (vert=E[x]; vert; vert=vert->next)
    if (p[x]!=vert->v)
      dfs2(vert->v);
  if (x!=root)
    if (abs(count[x]- (n-count[x]))<=1)
      neededvert=numofp[x];
}

int main()
{
  init();
  n = getN();
  
  for (int i =0; i<n; i++)
    E[i]=0, count[i]=0, numofp[i]=0;

  for (int i=1; i<=n-1; i++)
      addedge(getA(i)-1, getB(i)-1, i);	

  for (int i=0; i<n; i++)
    if (count[i]==1)
    {
      root=i;
      p[root]=-1;
      dfs1(root);
      dfs2(root);
      break;
    }


  while (E[root])
  {
    int buf = query(neededvert->num);
    if (buf==0)
      root = getA(neededvert->num)-1;
    else
      root = getB(neededvert->num)-1;
    if (root==neededvert->v) 
      n = count[root];
    else
      n = n-count[root];
    p[root]=-1;
    del(neededvert);
    del(neededvert->rev);
    if (!E[root])
      report(root+1);
    dfs1(root);
    dfs2(root);
  }
  report(root+1);
}