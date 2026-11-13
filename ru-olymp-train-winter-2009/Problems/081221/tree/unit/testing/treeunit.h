#ifndef _TREEUNIT_H_
#define _TREEUNIT_H_

#ifdef __cplusplus
extern "C" {
#endif

void init();
int getN(void);
int getA(int edgeNum);
int getB(int edgeNum);
int query(int edgeNum);
void report(int vertexNum);

#ifdef __cplusplus
};
#endif

#endif
