// binsearch.cpp : Defines the initialization routines for the DLL.
//

#include "stdafx.h"
#include "binsearch.h"
#include "iostream"

using namespace std;

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

//
//TODO: If this DLL is dynamically linked against the MFC DLLs,
//		any functions exported from this DLL which call into
//		MFC must have the AFX_MANAGE_STATE macro added at the
//		very beginning of the function.
//
//		For example:
//
//		extern "C" BOOL PASCAL EXPORT ExportedFunction()
//		{
//			AFX_MANAGE_STATE(AfxGetStaticModuleState());
//			// normal function body here
//		}
//
//		It is very important that this macro appear in each
//		function, prior to any calls into MFC.  This means that
//		it must appear as the first statement within the 
//		function, even before any object variable declarations
//		as their constructors may generate calls into the MFC
//		DLL.
//
//		Please see MFC Technical Notes 33 and 58 for additional
//		details.
//


// CbinsearchApp

BEGIN_MESSAGE_MAP(CbinsearchApp, CWinApp)
END_MESSAGE_MAP()


// CbinsearchApp construction

CbinsearchApp::CbinsearchApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}


// The one and only CbinsearchApp object

CbinsearchApp theApp;


// CbinsearchApp initialization

BOOL CbinsearchApp::InitInstance()
{
	CWinApp::InitInstance();

	return TRUE;
}

#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

int queries;
int was = 0;
FILE* fout;
FILE* fin;

#define bool int
#define true 1
#define false 0

typedef int SostAr[65][65][65][2];

static int sn;
static int gn, gl, gr, first;
static bool galreadyLie;
static SostAr d, p;
static int wasError = 0;

extern "C" __declspec(dllexport) int getN() {
	if (wasError) return sn;
	if (was) {
		fout = fopen("31415926.out", "wt");
		fprintf(fout, "-1\ngetN called twice\n");
		fclose(fout);
		wasError = 1;
		return sn;
	}

	memset(d, 255, sizeof(d));
	memset(p, 255, sizeof(p));
	fin = fopen("31415926.in", "rt");
	fscanf(fin, "%d", &sn);
	fclose(fin);

	queries = 0;
	was = 1;

	sn++;
	gn = sn;
	gl = 0;
	gr = sn;
	first = 0;
	galreadyLie = false;
	return sn - 1;
}

int find(int n, int l, int r, bool alreadyLie) {
	int i;
	if (r <= 0) {
		return find(n - l, 0, n - l, true);		
	}
	if (l >= n) {
		return find(r, 0, r, true);
	}
	int *res = &d[n][l][r][alreadyLie];
	int *move = &p[n][l][r][alreadyLie];
	if (*res > -1) return *res;
	if (n <= 1) {
		*res = 0;
		*move = 1;
		return 0;
	}
	*res = (int)(1E+9);
	if (alreadyLie) {
		for(i = 1; i < n; ++i) {
			int nres = max(find(i, 0, i, true), find(n - i, 0, n - i, true));
			if (*res > nres + 1) {
				*res = nres + 1;
				*move = i;
			}
		}
	} else {
		for(i = 1; i < n; ++i) {
			int nres = (int)(1E+9);
			if (i <= min(l, r)) {
				nres = max(find(r, l, i, false), find(n - i, l - i, r - i, false));
			}
			if (i >= max(l, r)) {
				nres = max(find(i, l, r, false), find(n - l, i - l, r - l, false));
			}
			if (l < i && i < r) {
				nres = max(find(r, l, i, false), find(n - l, i - l, r - l, false));
			}
			if (r <= i && i <= l) {
				nres = max(find(r, 0, r, true), find(n - l, 0, n - l, true));
			}
			if (*res > nres + 1) {
				*res = nres + 1;
				*move = i;
			}				
		}
	}
	return *res;
}

void newState(int n, int l, int r, bool alreadyLie) {
	gn = n;
	gl = l;
	gr = r;
	galreadyLie = alreadyLie;
}

bool getAnswer(int n, int l, int r, bool alreadyLie, int i) {
	if (r <= 0) {
		first += l;
		return getAnswer(n - l, 0, n - l, true, i);		
	}
	if (l >= n) {
		return getAnswer(r, 0, r, true, i);
	}
	if (n <= 1) {
		newState(n, l, r, alreadyLie);
		return true; // no matter! Contestant already know answer!
	}
	if (alreadyLie) {
   		if (find(i, 0, i, true) > find(n - i, 0, n - i, true)) {
			newState(i, 0, i, true);
			return true;
   		} else {
   			first += i;
			newState(n - i, 0, n - i, true);
			return false;
   		}
	} else {
   		if (i <= min(l, r)) {
   			if (find(r, l, i, false) > find(n - i, l - i, r - i, false)) {
   				newState(r, l, i, false);
   				return true;
   			} else {
   				first += i;
   				newState(n - i, l - i, r - i, false);
   				return false;
   			}
   		}
   		if (i >= max(l, r)) {
   			if (find(i, l, r, false) > find(n - l, i - l, r - l, false)) {
   				newState(i, l, r, false);
   				return true;
   			} else {
   				first += l;
   				newState(n - l, i - l, r - l, false);
   				return false;
   			}
   		}
   		if (l < i && i < r) {
   			if (find(r, l, i, false) > find(n - l, i - l, r - l, false)) {
				newState(r, l, i, false);
				return true;
   			} else {
   				first += l;
   				newState(n - l, i - l, r - l, false);
   				return false;
   			}
   		}
   		if (r <= i && i <= l) {
   			if (find(r, 0, r, true) > find(n - l, 0, n - l, true)) {
   				newState(r, 0, r, true);
				return true;
   			} else {
   				first += l;
   				newState(n - l, 0, n - l, true);
				return false;
   			}
   		}
	}
}

extern "C" __declspec(dllexport) int query(int i) {
	if (wasError) return 0;
	cerr << "query == " << i << endl;
	if (!was) {
		fout = fopen("31415926.out", "wt");
		fprintf(fout, "-1\nquery called before getN\n");
		fclose(fout);
		wasError = 1;
		return 0;
	}
	if (i < 1 || i >= sn) {
		fout = fopen("31415926.out", "wt");
		fprintf(fout, "-1\ninvalid query");
		fclose(fout);
		wasError = 1;
		return 0;
	}
	queries++;
	i -= first;

	if (i < 1) {
		return false; // Now I can be sure, that answer is incorrect
	}
	if (i >= gn) {
		return true;  // Now I can be sure, that answer is incorrect
	}
	return getAnswer(gn, gl, gr, galreadyLie, i);
}

extern "C" __declspec(dllexport) void answer(int i) {
	if (wasError) return ;
	cerr << "answer == " << i << endl;
	if (!was) {
		fout = fopen("31415926.out", "wt");
		fprintf(fout, "-1\nanswer called before getN\n");
		fclose(fout);
		wasError = 1;
		return ;
	}
	fout = fopen("31415926.out", "wt");
	if (gn >= 2) {
		fprintf(fout, "-1\nTrying to guess\n");
		fclose(fout);
		wasError = 1;
		return ;
	}
	if (i != first + 1) {
		fprintf(fout, "-1\nWrong answer %d. Correct answer is %d\n", i, first + 1);
		fclose(fout);
		wasError = 1;
		return ;
	}
	fprintf(fout, "%d\n", queries);
   	fclose(fout);
	cerr << "!!!!!" << endl;
}

#undef true
#undef false
#undef bool


