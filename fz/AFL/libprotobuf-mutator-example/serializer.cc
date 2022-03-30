#include "test.pb.h"
#include <bits/stdc++.h>

using std::cin;
using std::cout;
using std::endl;

int main(int argc, char *argv[])
{
    TEST t;
    t.set_a(100);
    t.set_b("aaaa");
    std::string s;
    t.SerializeToString(&s);

    std::ofstream out("./in/ii");
    out << s;
    out.close();
    return 0;
}    