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
  string str = file; str = lcase(str);
  //if (string(str, 0, 7) == "program") answer(false);
  if (str.find("close(") < str.size()) answer(false);
  if (str.find(":)") < str.size()) answer(false);
  if (str.find(":(") < str.size()) answer(false);
  if (str.find("-)") < str.size()) answer(false);
  if (str.find("-(") < str.size()) answer(false);
  if (string(str, 0, 2) == "//") answer(true);
  if (str.find("zadach") < str.size()) answer(false);
  if (str.find(";;") < str.size()) answer(false);
  if (str.find("tar") < str.size()) answer(false);
  answer(true);
  if (str.find(": ") < str.size()) answer(true);
  if (str.find("compil") < str.size()) answer(true);
  if (str.find("checker") < str.size()) answer(true);
  if (str.find("lib") < str.size()) answer(true);
  if (str.find("asm") < str.size()) answer(true);
  if (str.find("randseed") < str.size()) answer(true);
  if (str.find("__") < str.size()) answer(true);  
  if (str.find("soluti") < str.size()) answer(true);
  if (str.find("solv") < str.size()) answer(true);
  if (str.find("judge") < str.size()) answer(true);
  if (str.find("jury") < str.size()) answer(true);
  
  bool instr = 0;
  int found = 0;
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
    if (found == 2) {
      string comment =
      string(str, i + 1, str.find("\n", i + 1) - i - 1);
      for (int i = 0; i < comment.size(); i++)
	if (is_rus(comment[i])) answer(false);
      if (comment.find("created", 0) < comment.size()) answer(true);
      if (comment.find("powered", 0) < comment.size()) answer(true);
      if (comment.find("author", 0) < comment.size()) answer(true);
    }
  }
  
  answer(false);
  return 0;
}