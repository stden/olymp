#include <iostream>
#include <algorithm>
#include <cmath>
#include <vector>
#include <string>
#include <cstdio>
#include <cassert>

#ifdef SHTRIX
#include "/Users/roman/Dev/SharedCpp/DebugOutput.h"
#endif

using namespace std;

int charToNum(char c) {
        if (c == 'A') return 0;
        if (c == 'G') return 1;
        if (c == 'T') return 2;
        if (c == 'V') return 3;
        return 4;
}

inline int f(vector<int> p) {
        int res = 0;
        while (count(p.begin(), p.end(), 0) != p.size()) {
                for (int i = 0; i < p.size(); i++)
                        if (p[i]) {
                                int j = i;
                                for (; j < p.size(); j++)
                                                if (p[j] == 0) {
                                                        break;
                                                }
                                int mn = 1000000000;
                                for (int k = i; k < j; k++) mn = min(mn, p[k]);
                                for (int k = i; k < j; k++) p[k] -= mn;
                                res += mn;
                                break;
                        }
        }
        return res;
}

inline int solve1(const vector<int> &a, const vector<int> &b) {
        vector<int> c;
        for (int i = 0; i < a.size(); i++) {
                c.push_back(b[i] - a[i]);
                if (c[i] < 0) c[i] += 4;
        }
        vector<int> ca(1, a[0]), cb(1, b[0]);
        vector<int> p(1, c[0]);
        for (int i = 1; i < c.size(); i++) {
                if (p.back() != c[i]) {
                        ca.push_back(a[i]);
                        cb.push_back(b[i]);
                        p.push_back(c[i]);
                }
        }
        int fcur = f(p);
        for (int l = 1; l <= p.size(); l++) {
                for (int i = 0; i < p.size(); i++) {
                        int j = i + l;
                        if (j >= p.size()) continue;
                        vector<int> t = p;
                        for (int k = i; k < j; k++)
                                t[k] += 4;
                        int ft = f(t);
                        if (ft < fcur) {
                                fcur = ft;
                                p = t;
                        }
                }
        }
        return fcur;
}

inline int solve2(const vector<int> &a, const vector<int> &b) {
        vector<int> c;
        for (int i = 0; i < a.size(); i++) {
                c.push_back(b[i] - a[i]);
                if (c[i] < 0) c[i] += 4;
        }
        vector<int> ca(1, a[0]), cb(1, b[0]);
        vector<int> p(1, c[0]);
        for (int i = 1; i < c.size(); i++) {
                if (p.back() != c[i]) {
                        ca.push_back(a[i]);
                        cb.push_back(b[i]);
                        p.push_back(c[i]);
                }
        }
        int fcur = f(p);
        for (int l = p.size(); l >= 1; l--) {
                for (int i = p.size() - 1; i >= 0; i--) {
                        int j = i + l;
                        if (j >= p.size()) continue;
                        vector<int> t = p;
                        for (int k = i; k < j; k++)
                                t[k] += 4;
                        int ft = f(t);
                        if (ft < fcur) {
                                fcur = ft;
                                p = t;
                        }
                }
        }
        return fcur;
}

inline int solve3(const vector<int> &a, const vector<int> &b) {
        vector<int> c;
        for (int i = 0; i < a.size(); i++) {
                c.push_back(b[i] - a[i]);
                if (c[i] < 0) c[i] += 4;
        }
        vector<int> ca(1, a[0]), cb(1, b[0]);
        vector<int> p(1, c[0]);
        for (int i = 1; i < c.size(); i++) {
                if (p.back() != c[i]) {
                        ca.push_back(a[i]);
                        cb.push_back(b[i]);
                        p.push_back(c[i]);
                }
        }
        int fcur = f(p);
        for (int l = 1; l <= p.size(); l++) {
                for (int i = p.size() - 1; i >= 0; i--) {
                        int j = i + l;
                        if (j >= p.size()) continue;
                        vector<int> t = p;
                        for (int k = i; k < j; k++)
                                t[k] += 4;
                        int ft = f(t);
                        if (ft < fcur) {
                                fcur = ft;
                                p = t;
                        }
                }
        }
        return fcur;
}

inline int solve4(const vector<int> &a, const vector<int> &b) {
        vector<int> c;
        for (int i = 0; i < a.size(); i++) {
                c.push_back(b[i] - a[i]);
                if (c[i] < 0) c[i] += 4;
        }
        vector<int> ca(1, a[0]), cb(1, b[0]);
        vector<int> p(1, c[0]);
        for (int i = 1; i < c.size(); i++) {
                if (p.back() != c[i]) {
                        ca.push_back(a[i]);
                        cb.push_back(b[i]);
                        p.push_back(c[i]);
                }
        }
        int fcur = f(p);
        for (int l = p.size(); l >= 1; l--) {
                for (int i = 0; i < p.size(); i++) {
                        int j = i + l;
                        if (j >= p.size()) continue;
                        vector<int> t = p;
                        for (int k = i; k < j; k++)
                                t[k] += 4;
                        int ft = f(t);
                        if (ft < fcur) {
                                fcur = ft;
                                p = t;
                        }
                }
        }
        return fcur;
}

inline int solvex(const vector<int> &a, const vector<int> &b) {
        vector<int> c;
        for (int i = 0; i < a.size(); i++) {
                c.push_back(b[i] - a[i]);
                if (c[i] < 0) c[i] += 4;
        }
        vector<int> ca(1, a[0]), cb(1, b[0]);
        vector<int> p(1, c[0]);
        for (int i = 1; i < c.size(); i++) {
                if (p.back() != c[i]) {
                        ca.push_back(a[i]);
                        cb.push_back(b[i]);
                        p.push_back(c[i]);
                }
        }
        int fcur = f(p);
        while (true) {
                vector<pair<int, pair<int, int> > > segs;
                for (int l = 1; l <= p.size(); l++) {
                        for (int i = 0; i < p.size(); i++) {
                                int j = i + l;
                                if (j >= p.size()) continue;
                                vector<int> t = p;
                                for (int k = i; k < j; k++)
                                        t[k] += 4;
                                int ft = f(t);
                                if (ft < fcur)
                                        segs.push_back(make_pair(ft, make_pair(i, j)));
                        }
                }
                sort(segs.begin(), segs.end());
                if (segs.size() == 0) return fcur;
                for (int k = segs[0].second.first; k < segs[0].second.second; k++)
                        p[k] += 4;
                fcur = segs[0].first;
        }
        return fcur;
}

inline int solvey(const vector<int> &a, const vector<int> &b) {
        vector<int> c;
        for (int i = 0; i < a.size(); i++) {
                c.push_back(b[i] - a[i]);
                if (c[i] < 0) c[i] += 4;
        }
        vector<int> ca(1, a[0]), cb(1, b[0]);
        vector<int> p(1, c[0]);
        for (int i = 1; i < c.size(); i++) {
                if (p.back() != c[i]) {
                        ca.push_back(a[i]);
                        cb.push_back(b[i]);
                        p.push_back(c[i]);
                }
        }
        int fcur = f(p);
        while (true) {
                vector<pair<int, pair<int, int> > > segs;
                for (int l = 1; l <= p.size(); l++) {
                        for (int i = 0; i < p.size(); i++) {
                                int j = i + l;
                                if (j >= p.size()) continue;
                                vector<int> t = p;
                                for (int k = i; k < j; k++)
                                        t[k] += 4;
                                int ft = f(t);
                                if (ft < fcur)
                                        segs.push_back(make_pair(ft, make_pair(i, j)));
                        }
                }
                sort(segs.begin(), segs.end());
                if (segs.size() == 0) return fcur;
                reverse(segs.begin(), segs.end());
                for (int k = segs[0].second.first; k < segs[0].second.second; k++)
                        p[k] += 4;
                fcur = segs[0].first;
        }
        return fcur;
}

inline int solve(const vector<int> &a, const vector<int> &b) {
        return min(min(min(solve1(a, b), solve2(a, b)), min(solve3(a, b), solve4(a, b))), min(solvey(a, b), solvex(a, b)));
}


int main() {
        #ifndef SHTRIX
                freopen("a.dat", "rt", stdin);
                freopen("a.sol", "wt", stdout);
        #endif
        int n;
        scanf("%d", &n);
        vector<int> a(n), b(n);
        for (int i = 0; i < n; i++) scanf("%d", &a[i]);
        for (int i = 0; i < n; i++) scanf("%d", &b[i]);
        cout << solve(a, b) << endl;
        return 0;
}
