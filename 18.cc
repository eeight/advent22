#include <iostream>
bool b[256*256*256];
int cs[10000];
int n;
int ns[] = {-1, 1, -256, 256, -256*256, 256*256};
int s[256*256*256*10];

int solve()
{
    int res = 0;
    for (int i = 0; i != n; ++i) {
        for (int y:ns) res += !b[cs[i]+y];
    }
    return res;
}

void dfs()
{
    int* t = s + 1;
    while (t > s) {
        int k = *--t;
        if (k >= 0 && k < 256*256*256 && b[k]) {
            b[k] = true;
            for (int y:ns)*t++ = k + y;
        }
    }
}

int main()
{
    unsigned char* x = (unsigned char*)cs;
    for(int c; (c = getchar()) != EOF;)
    {
        if (isdigit(c)) *x = *x*10 + c - '0';
        else {
            *x += 1 + 256 + 256*256;
            x += 1 + (c != ',');
        }
    }
    n = (int *)x - cs;
    for (int i = 0; i != n; ++i) {
        b[cs[i]] = true;
    }
    int l = solve();
    std::cout << l << '\n';
    dfs();
    std::cout << l - solve() << '\n';
}
