// binsearch.h : main header file for the binsearch DLL
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'stdafx.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CbinsearchApp
// See binsearch.cpp for the implementation of this class
//

class CbinsearchApp : public CWinApp
{
public:
	CbinsearchApp();

// Overrides
public:
	virtual BOOL InitInstance();

	DECLARE_MESSAGE_MAP()
};
