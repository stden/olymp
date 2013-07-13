//Задача "Перестановки"
//Региональный этап Всероссийской олимпиады школьников по информатике
//Автор задачи: Сергей Мельников, melnikov@rain.ifmo.ru
//Автор решения: Максим Буздалов, buzdalov@rain.ifmo.ru

//Решение за O(N * N!) с двумя эвристиками по входным данным и отсечением по количеству итераций.
//Эвристики: 
// 1. Если gcd всех входных чисел >= k, то ответ выбирается селекцией, аналогичной правильному
//    решению - для этого случая ответы для подмножеств известны (факториалы).
// 2. Если gcd любой пары входных чисел < k, то ответ -1 (это правда). 
// 3. Если при поиске по перестановкам произошло 1000000 next_permutation, то скажем, что ответ -1.

#include <algorithm>
#include <cstdio>

int main()
{   
    freopen("perm.in", "rt", stdin);
    freopen("perm.out", "wt", stdout);
    
    int n, m, k;
    scanf("%d%d%d", &n, &m, &k);
    
    int numbers[16];
    for (int i = 0; i < n; ++i) 
    {
        scanf("%d", numbers + i);
    }
    
    std::sort(numbers, numbers + n);
    
    int gcd[16][16];
    
    bool allOk = true;
    bool allBad = true;
    
    for (int i = 0; i < n; ++i)
    {
        for (int j = 0; j < n; ++j)
        {
            int a = numbers[i], b = numbers[j];
            while (a)
            {
                int t = b % a;
                b = a;
                a = t;
            }
            gcd[i][j] = b;
            allOk &= b >= k;
            allBad &= b < k;
        }
    }

    allOk |= n == 1;
    
    if (allOk)
    {
        long long fact[17];
        fact[0] = 1;
        for (int i = 1; i <= 16; ++i)
        {
            fact[i] = i * fact[i - 1];
        }
        
        fprintf(stderr, "factorial part\n");
        
        if (fact[n] >= m)
        {
            bool used[16];
            for (int i = 0; i < 16; ++i)
            {
                used[i] = false;
            }
            for (int i = 0; i < n; ++i)
            {
                for (int j = 0; j < n; ++j) {
                    if (used[j]) continue;
                    if (fact[n - i - 1] >= m)
                    {
                        printf("%d ", numbers[j]);
                        used[j] = true;
                        break;
                    }
                    m -= fact[n - i - 1];
                }
            }
        } 
        else
        {
            printf("-1\n");
        }
    }
    else if (allBad)
    {
        fprintf(stderr, "all is bad\n");
        printf("-1\n");
    }
    else
    {
        int pi[16];
        for (int i = 0; i < 16; ++i)
        {
            pi[i] = i;
        }

        int itcount = 0;

        do        
        {
            bool ok;
            do
            {
                ok = true;
                for (int i = 1; ok && i < n; ++i)
                {
                    ok &= gcd[pi[i - 1]][pi[i]] >= k;
                }
                if (!ok)
                {
                    if (!std::next_permutation(pi, pi + n))
                    {
                        printf("-1\n");
                        return 0;
                    }
                    ++itcount;
                    if (itcount > 10000000)
                    {
                        printf("-1\n");
                        return 0;
                    }
                }
            }
            while (!ok);
            
            if (!--m)
            {
                for (int i = 0; i < n; ++i)
                {
                    printf("%d ", numbers[pi[i]]);
                }
                return 0;
            }
        }
        while (std::next_permutation(pi, pi + n));
        printf("-1\n");
        return 0;
    }
    
    return 0;
}
