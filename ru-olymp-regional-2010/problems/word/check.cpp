#define NOFOOTER

#include "testlib.h"

#include <algorithm>
#include <sstream>
#include <string>
#include <vector>

struct outcome_handler
{
    virtual void wa(std::string const &str) const = 0;
};

struct jury_handler : outcome_handler
{
    virtual void wa(std::string const &str) const
    {
        quitf(_fail, str.c_str());
    }
};

struct cont_handler : outcome_handler
{
    virtual void wa(std::string const &str) const
    {
        quitf(_wa, str.c_str());
    }
};

void validate
(
    std::vector<std::string> const &dict, 
    std::string const &word, 
    std::vector<int> const &indices, 
    outcome_handler const &handler
)
{
    for (int i = 0; i < indices.size(); ++i)
    {
        if (indices[i] < 1 || indices[i] > dict.size())
        {
            std::ostringstream oss;
            oss << "Illegal index at position " << i + 1;
            handler.wa(oss.str());
        }
    } 
    std::string concat;
    for (int i = 0; i < dict[0].length(); ++i)
    {
        for (int j = 0; j < indices.size(); ++j)
        {
            concat.push_back(dict[indices[j] - 1][i]);
        }
    }
    if (concat.find(word) == std::string::npos)
    {
        handler.wa("The word is not contained as a substring");
    }
}

int main(int argc, char *argv[])
{
    registerTestlibCmd(argc, argv);

    int n = inf.readInt();
    int w = inf.readInt();
    inf.eoln();
    
    std::vector<std::string> dict(n);
    for (int i = 0; i < n; ++i)
    {
        dict[i] = inf.readString();
        if (dict[i].length() != w) 
        {
            quitf(_fail, "Input is not correct");
        }
    }
    std::string word = inf.readString();
    
    int jury = ans.readInt();
    if (jury != -1) 
    {
        if (jury < 0) 
        {
            quitf(_fail, "Jury answer is less than -1");
        }
        if (jury > word.length()) 
        {
            quitf(_fail, "Jury answer makes no sense: it is greater than word's length");
        }
        std::vector<int> indices(jury);
        for (int i = 0; i < jury; ++i) 
        {
            indices[i] = ans.readInt();
        }
        validate(dict, word, indices, jury_handler());
    }
    
    int cont = ouf.readInt();
    if (cont != -1)
    {
        if (cont < 0) 
        {
            quitf(_wa, "Contestant's answer is less than -1");
        }
        if (cont > word.length())
        {
            quitf(_wa, "Contestant's answer makes no sense: it is greater than word's length");
        }
        std::vector<int> indices(cont);
        for (int i = 0; i < cont; ++i)
        {
            indices[i] = ouf.readInt();
        }
        validate(dict, word, indices, cont_handler());
    }
    
    if (jury == -1 && cont != -1)
    {
        quitf(_fail, "Contestant found an answer while jury didn't");
    }
    if (jury != -1 && cont == -1)
    {
        quitf(_wa, "Contestant didn't find an answer");
    }
    if (jury > cont)
    {
        quitf(_fail, "Contestant found a better answer");
    }
    if (jury < cont)
    {
        quitf(_wa, "Jury found a better answer");
    }
    quitf(_ok, "Ok (%d)", jury);
}
