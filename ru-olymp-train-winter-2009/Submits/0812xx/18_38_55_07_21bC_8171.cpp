#include <fstream>

using namespace std;

int main()
{
ofstream fout("apache.out");
fout << "195.19.224.104 - abc [02/Dec/2004:15:25:19 -0200] \"GET / HTTP/1.1\" 304 -"<< '\n';
fout << "195.19.224.104 - - [02/Dec/2004:15:25:19 -0200] \"GET /main.css HTTP/1.1\" 304 -"<< '\n';
fout <<"195.19.224.79 - - [02/Dec/2004:15:58:20 -0200] \"GET /tts HTTP/1.1\" 302 293"<< '\n';
fout <<"195.19.224.79 - - [02/Dec/2004:15:58:20 -0200] \"GET /tts/ HTTP/1.1\" 302 303" << '\n';
fout <<"207.46.98.42 - - [02/Dec/2004:23:39:32 -0200] \"GET /robots.txt HTTP/1.0\"";
}