K = 90
def pack(s):
    if s == "":
        return 0
    else:
        return pack(s[1:])*K + ord(s[0]) - ord(' ')

def unpack(n):
    if n == 0:
        return ""
    else:
        d, m = divmod(n, K)
        return chr(m) + unpack(d)

ns = [100, 120, 1000, 913]

class Encoder:
    def __init__(self):
        self.basis = [5,3,2,1]
        self.known = set(self.basis)
        self.to_encode = []

    def encode_all(self, xs):
        self.to_encode += [x for x in xs if x not in self.known]
        results = []
        while len(self.to_encode) > 0:
            y = self.to_encode.pop()
            if y in self.known:
                continue
            results.append((y, self.encode(y)))
            self.known.add(y)

        for y, code in sorted(results):
            def mkpow(x, i):
                if i == 1:
                    return f"_{x}"
                else:
                    return f"pow(_{x}, _{i})"
            if len(code) > 1:
                print("_{} = sum(({}))".format(y, ", ".join(mkpow(x, i) for x, i in code)))
            else:
                x, i = code[0]
                print("_{} = {}".format(y, mkpow(x, i)))
            print(f"assert(_{y} == {y})")

    def encode(self, y):
        return self.__encode(self.basis, y)

    def __encode(self, xs, y):
        x = xs[0]
        i = 1
        if x > 1:
            while x**i < y:
                i += 1

        subresult = []

        while i >= 1:
            while x**i <= y:
                subresult.append((x, i))
                if i not in self.known:
                    self.to_encode.append(i)
                y -= x**i
            i -= 1

        if y > 0:
            return subresult + self.__encode(xs[1:], y)
        else:
            return subresult

strs = ["operator", "getitem", "sub", "mul", "ifloordiv", "eq", "lt", "imod", "sys", "argv", ": ", ", ", "*", "old", "= ", "math", "stdin"]
Encoder().encode_all([pack(t) for t in strs])
for t in strs:
    print("# '{}' = _{} # {}".format(t, pack(t), t))


for r in "_ _0 _1 __1 __str0 __str1 __str10 __str11 __str12 __str13 __str14 __str15 __str17 __str3 __str4 __str5 __str6 __str7 __str8 __str9 acc at at0 at1 bind_2nd bv callif cond cont curry d e eq es f fix g ga gg i ii im int ite j k ks l last_int lt m mapl maxes monkeys mul n new_acc nn ns old op r read result round s self ss sub super t tail tail7 test thunk times tt unpack unpack_ ww www x xs xx xxx y ys yy zz".split():
    pass
