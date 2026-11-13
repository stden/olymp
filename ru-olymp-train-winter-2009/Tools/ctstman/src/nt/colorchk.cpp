#include <windows.h>
#include <stdio.h>

char str [256];
int color;
int oklen;


void tryit (const char *s, int pc)
{
  int len=strlen (s);
  if (!memcmp (str+2, s, len)) oklen=len, color=pc;
};

int main ()
{
  CONSOLE_SCREEN_BUFFER_INFO cinfo;
  DWORD tmp;

  if (fgets (str, sizeof (str), stdin)==NULL) return 0;
  int t=strlen (str);
  if (t&&str[t-1]=='\n') str[t-1]=0, --t;
  color=7; oklen=0;
  tryit ("Облом", 12);
  tryit ("Формат в/в", 13);
  tryit ("Неверный ответ", 9);
  tryit ("ok", 10);
  if (strlen (str)<oklen+4) oklen=0;
  if (!oklen) {_label:fprintf (stderr, "%s\n", str);}
  else
  {
    oklen+=4;
    HANDLE chandle=GetStdHandle (STD_ERROR_HANDLE);
    if (GetConsoleScreenBufferInfo (chandle, &cinfo)==FALSE) goto _label;
    fprintf (stderr, "%.*s", oklen, str);
    FillConsoleOutputAttribute (chandle, color,
                                oklen, cinfo.dwCursorPosition, &tmp);
    t=strlen (str);
    if (t>=cinfo.dwSize.X)
    {
      fprintf (stderr, "%.*s", cinfo.dwSize.X-oklen, str+oklen);
      GetConsoleScreenBufferInfo (chandle, &cinfo);
      FillConsoleOutputAttribute (chandle, 7, cinfo.dwSize.X, cinfo.dwCursorPosition, &tmp);
      fprintf (stderr, "%s\n", str+cinfo.dwSize.X);
    }
    else fprintf (stderr, "%s\n",  str+oklen);
    GetConsoleScreenBufferInfo (chandle, &cinfo);
    FillConsoleOutputAttribute (chandle, 7, cinfo.dwSize.X, cinfo.dwCursorPosition, &tmp);
  };
  while (!feof (stdin))
  {
    if (fgets (str, sizeof (str), stdin)==NULL) return 0;
    int t=strlen (str);
    if (t&&str[t-1]=='\n') str[t-1]=0, --t;
    fprintf (stderr, "%s\n", str);
  };
  return 0;
};
