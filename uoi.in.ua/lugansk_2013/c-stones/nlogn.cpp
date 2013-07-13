#define maxn 200000

#include <stdio.h>
#include <algorithm>

using namespace std;

int n, m, i, op, t, w;
int c[maxn];    // �������� ������� �������, �� ������� � ������� ���
int ws[maxn];   // ������� ����� ��� ������� � ��� ���
int ws_start[maxn]; // ws_start[i] � ������ � ����� ws, � ����� ���������� ������� ������, �� ������� ���� i, 0 <= i < m
int cnt[maxn];  // ʳ������ ������� � ����� ������ ������� � ������� ���
pair<int, int> heap2[maxn]; // ����� (������ ����) ��������� ��� ������� � ������� ��� (�� � ���� � ���� �������) ����� �� ������, � ���� ���� ��������
int heap2_town_index[maxn]; // heap2_town_index[i] � ������ � ����� heap2 ��������, �� ������� ������ � ���� i (��� -1, ���� � i-�� ��� ���� ������� ������), 0 <= i < m
int cnt2;   // ˳������� ������� �������� � ��� ������� ����

/*
������� ���� ������ � ����� ������� � ������ ���.
town � ����� ���� (�� 0 �� m-1)
place � ����� ���� (�� 0 �� cnt[town]-1)
*/
inline int getW(int town, int place)
{
    return ws[ws_start[town] + place];
}

/*
���� ���� ������ � ����� ������� � ������ ���.
town � ����� ���� (�� 0 �� m-1)
place � ����� ����
w � ���� ������
*/
inline void setW(int town, int place, int w)
{
    ws[ws_start[town] + place] = w;
}

/*
������ ������ ���� ���� ������� � ������ ���.
town � ����� ���� (�� 0 �� m-1)
place1, place2 � ������ ���� (�� 0 �� cnt[town]-1)
*/
inline void swap_within_town(int town, int place1, int place2)
{
    int tmp = getW(town, place1);
    setW(town, place1, getW(town, place2));
    setW(town, place2, tmp);
}

/*
�������� ������� ������ ���� �� �������� ���� � ���� ������� ����.
w � ���� ������
town_from � ����� ����, � ����� �������� ������� (�� 0 �� m-1)
*/
inline void insert2(int w, int town_from)
{
    heap2[cnt2].first = w;  // ���������� � ����� ���� ������� ���� ���������� ��� �������
    heap2[cnt2].second = town_from;
    heap2_town_index[town_from] = cnt2; // ��������� ������ ���� � ��� ��� ����, � ����� �������� �������
    int cur = cnt2, newCur; // ����, �������� ��� ������ �������� (���. �����)
    cnt2++; // �������� �� 1 �������� �������� � ���
    while (cur > 0 && heap2[cur].first > heap2[newCur = (cur - 1) / 2].first)   // ϳ������ �������, ���� �� �� ��������� �� ������ ����
    {
        swap(heap2_town_index[heap2[cur].second], heap2_town_index[heap2[newCur].second]);  // ����� �� ������ ���������� ���� ��������� ������� ������ ��� �������
        swap(heap2[cur], heap2[newCur]);
        cur = newCur;
    }
}

/*
������ (����� ���������) ������� ���� ������� ����, ���� �� �� ��������� �� ������ ����.
index � ������� ����, ���� ��������� �������� (�� 0 �� cnt2-1)
*/
inline void descend2(int index)
{
    int cur = index, max, left, right;
    while (true)
    {
        left = 2 * cur + 1;
        right = left + 1;
        max = cur;
        if (left < cnt2 && heap2[left].first > heap2[max].first)
            max = left;
        if (right < cnt2 && heap2[right].first > heap2[max].first)
            max = right;
        if (max != cur)
        {
            swap(heap2_town_index[heap2[cur].second], heap2_town_index[heap2[max].second]); // ����� �� ������ ���������� ���� ��������� ������� ������ ��� �������
            swap(heap2[cur], heap2[max]);
            cur = max;
        } else
            break;
    }
}

/*
������ ������� ���� ������� ����, ���� ������� ������ ����, �� ������ ���� �� �������� ��������� ����.
w � ���� ����
town_from � ���� (�� 0 �� m-1), ��������� ����� ������� ����� ��������
*/
inline void update2(int w, int town_from)
{
    heap2[heap2_town_index[town_from]].first = w;   // ���������
    descend2(heap2_town_index[town_from]);  // ³��������� ��������� ����
}

/*
���� �� ���� ������� ����, �� ������� ������ ����, ���� ���� �� � ��� ����������� ������� ��������� ����� ���� ������� ����.
town � ���� (�� 0 �� m-1), �� ���� ����� ������� ������ ����
w � ���� ������
*/
inline void insert(int town, int w)
{
    setW(town, cnt[town], w);   // ������ ���� � �����, �� ������� ���
    int cur = cnt[town], newCur;    // ����, �������� ��� ������ �������� (���. �����)
    cnt[town]++;    // �������� �� 1 �������� ������� �������� � ���
    while (cur > 0 && getW(town, cur) < getW(town, newCur = (cur - 1) / 2)) // ϳ������ �������, ���� �� �� ��������� �� ������ ����
    {
        swap_within_town(town, cur, newCur);
        cur = newCur;
    }
    if (cur == 0)   // ���� ������� ������� ������ � ��� ��� � ����� ��������� ���������
    {
        if (cnt[town] == 1) // ���� ������� ������� ������ � ���, ������ ���� �� ���� ������� ����
            insert2(w, town);
        else    // ������ (���� ������� � ����� ���������), ��������� �������, �� ������� ������ ����, � ��� ������� ����
            update2(w, town);
    }
}

/*
������� ������ ������� ���� ������� ����, �� ������� ������ ����.
town � ����� ���� (�� 0 �� m-1)
*/
inline void remove(int town)
{
    setW(town, 0, getW(town, cnt[town] - 1));   // ��������� ������� ������� ���� �� ����� ����
    cnt[town]--;    // �������� �� 1 �������� ������� �������� � ���
    int cur = 0, min, left, right;
    while (true)    // �������� ���������� �������, ���� �� �� ��������� �� ������ ����
    {
        left = 2 * cur + 1;
        right = left + 1;
        min = cur;
        if (left < cnt[town] && getW(town, left) < getW(town, min))
            min = left;
        if (right < cnt[town] && getW(town, right) < getW(town, min))
            min = right;
        if (min != cur)
        {
            swap_within_town(town, cur, min);
            cur = min;
        } else
            break;
    }
}

/*
������� ������ ������� ���� ������� ����, � ����� ��������� ���� ������� ���� ������� ����; ���� ����� ������ ������� ���� ������� ���� (���� ����� �) �� ���� ������� ����.
������� ���� ���������� ��������.
*/
inline int remove2()
{
    int result = heap2[0].first;    // ���� ��������, ���� �� ��������� ��������
    int town_from = heap2[0].second;    // � ����� ���� �������� �������, ���� �� ��������� ��������
    swap(heap2[0], heap2[cnt2 - 1]);    // �������� ������ ������ �� ������� ������� ����
    heap2_town_index[heap2[0].second] = 0;  // ��������� ������ ��� ����, � ����� �������� ������ �������, � ����� ������ ������� ����
    heap2_town_index[heap2[cnt2 - 1].second] = -1;  // ��������� ������ ��� ����, � ����� �������� �������, �� �� �������� (���� ���� ��������� ����� �������� � ���� ������� ���� ���������� ���� ��� ���������� ���� � ���� �������, ��� ������ ���� ��������� ���� ������� insert2 � ���. �����)
    cnt2--; // �������� �� 1 �������� ������� �������� � ���
    descend2(0);    // ³��������� ��������� ����

    remove(town_from);  // ��������� ������� � ���� ���� ������� ����
    if (cnt[town_from] > 0) // ���� � ��� ��� ������� ���� ������� ���� � ���� �������, ������ ����� �� ��������� ������� �� ���� ������� ����
        insert2(getW(town_from, 0), town_from);

    return result;  // ��������� ���� ���������� ��������
}

int main()
{
    freopen("stones.dat", "r", stdin);
    freopen("stones.sol", "w", stdout);

    scanf("%d%d", &n, &m);

    /* ���������� ����� c */
    for (i = 0; i < m; i++) // �����������
        c[i] = 0;
    for (i = 0; i < n; i++) // ϳ�������� �������
    {
        scanf("%d", &op);
        if (op == 1)
        {
            scanf("%d%d", &t, &w);
            t--;    // ��������� ��� � ������� � ����, � � �������� ���� � � �������
            c[t]++;
        }
    }
    /* ����� c ��������� */

    /* �� ����� ������ c ���������� ����� ws_start */
    ws_start[0] = 0;
    for (i = 1; i < m; i++)
        ws_start[i] = ws_start[i - 1] + c[i - 1];
    /* ����� ws_start ��������� */


    freopen("stones.dat", "r", stdin);  // ���� ���� ����������� ��������

    scanf("%d%d", &n, &m);

    cnt2 = 0;   // ����������� ��������� ���� ������� ����
    for (i = 0; i < m; i++)
    {
        cnt[i] = 0; // ����������� ��������� ��� ������� ����
        heap2_town_index[i] = -1;   // ����������� �������
        heap2[i] = make_pair(-1, -1);   // ���������� ��������� (���� �� �������) m �������� ���� ������� ����: ���� ������ ���� �������� ����� � ����� ���������� ������� �������� ������ ����, ��� ���������� � �������� ����� ��� �ᒺ���
    }

    for (i = 0; i < n; i++) // ����������� ����
    {
        scanf("%d", &op);
        if (op == 1)
        {
            scanf("%d%d", &t, &w);
            t--;    // ��������� ��� � ������� � ����, � � �������� ���� � � �������
            insert(t, w);
        } else
            printf("%d\n", remove2());
    }

    return 0;
}
