#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>
#include <list>
#include <string>

using namespace std;

#define TASKNAME "help"

void answer(bool result) {
  printf(result ? "YES\n" : "NO\n");
  exit(0);
}

int getcount(string str, string substr) {
  int res = 0;
  for (int pos = str.find(substr, 0); pos < str.size();
       pos = str.find(substr, pos + 1))
    res++;
  return res;
}

bool is_rus(char ch) {
  return ch > 127;
}

string lcase(string old) {
  string res = "";
  for (int i = 0; i < old.size(); i++) {
    if ((old[i] >= 'A') && (old[i] <= 'Z'))
      res += old[i] - 'A' + 'a';
    else
      res += old[i];
  }
  return res;
}

char file[1000000];

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  fread(file, 1, 1000000, stdin);
  string str = file;
  if (string(str, 0, 2) == "//") answer(true);
  if (lcase(string(str, 0, 7)) == "program") {
    string nop = string(str, 7, str.find(";") - 7);
    if (string(nop, 0, 3) == "zad") answer(false); //zadacha
  }
  bool instr = 0;
  int found = 0;/*
  for (int i = 0; i < str.size(); i++) {
    switch (str[i]) {
      case '"':
	if (!instr) instr = 1;
	else if (instr == 1) instr = 0;
	found = 0; break;
      case '\'':
	if (!instr) instr = 2;
	else if (instr == 2) instr = 0;
	found = 0; break;
      case '/':if (!instr) found++; break;
      default:found = 0; break;
    }
    //fprintf(stderr, "%c(%d)", str[i], instr);
    if (found == 2) {
      string comment =
      string(str, i + 1, str.find("\n", i + 1) - i - 1);
      for (int i = 0; i < comment.size(); i++)
	if (is_rus(comment[i])) answer(false);
    }
  }*/
  if (str.find("close(", 0) < str.size()) answer(false);
  if (str.find("Array", 0) < str.size()) answer(false);

  if (str.find("author", 0) < str.size()) answer(true);
  if (str.find("Author", 0) < str.size()) answer(true);
  if (str.find("powered", 0) < str.size()) answer(true);
  if (str.find("Powered", 0) < str.size()) answer(true);
  
  if (getcount(str, "\t") > 5) answer(false);
  
  int count = getcount(str, ":") - getcount(str, ": ");
  if (count > 1) answer(false);
  else answer(true);
  return 0;
}