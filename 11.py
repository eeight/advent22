im = __import__
es = str()
l = list
ss = sum

i = lambda x: x
k = lambda k: lambda _: k
s = lambda f: lambda g: lambda x: f(x)(g(x))

mapl = lambda f, xs: list(map(f, xs))
thunk = lambda x:lambda:x

fix = lambda f: f(f)

super = lambda f, g: lambda x: f(g(x))

_0 = len(())
_1 = len(((),))
__1 = es.find(chr(1))
nn = lambda x: abs(ss((__1, bool(x))))
at0 = super(next, iter)
at1 = lambda xs: (lambda i: (lambda j: next(i))(next(i)))(iter(xs))

callif = lambda cond, f: any(map(lambda f: f(), (lambda: nn(cond), lambda: k(True)(f()))))


bind_2nd = lambda f, y: lambda x: f(x, y)

unpack_ = fix(lambda self: lambda r, n: callif(n, lambda: (lambda x: (r.append(chr(at1(x))), self(self)(r, at0(x))))(divmod(n, 131)),))

unpack = lambda x: es.join((lambda r: (lambda j: r)(unpack_(r, x)))(l()))

__str0 = 76040627301029916 # operator
__str1 = 554807461225781 # getitem
__str3 = 1697220 # sub
__str4 = 1868824 # mul
__str5 = 10304190406959466094 # ifloordiv
__str6 = 14904 # eq
__str7 = 15304 # lt
__str8 = 226728355 # imod
__str9 = 1989481 # sys
__str10 = 267057352 # argv
__str11 = 4250 # : 
__str12 = 4236 # , 
__str13 = 42 # *
__str14 = 1730359 # old
__str15 = 4253 # = 
__str17 = 235804956 # math

curry = lambda f: lambda x: lambda y: f(x, y)
gg = curry(getattr)
ga = lambda x, y: super(gg(x), unpack)(y)
ii = super(im, unpack)

op = ii(__str0)
at = ga(op, __str1)
tail = bind_2nd(at, slice(1, 999))
tail7 = bind_2nd(at, slice(7, 999))

sub = ga(op, __str3)
mul = ga(op, __str4)
div = ga(op, __str5)
eq = ga(op, __str6)
lt = ga(op, __str7)
imod = ga(op, __str8)


ite = lambda i, t, e: at((e, t), i)()

xx = ite(eq(at1(ga(ii(__str9), __str10)), str(_1)), thunk((bind_2nd(div, 3), 20)), thunk((i, 10000)))

last_int = lambda x: int(at(x.split(), -1))

read = fix(lambda self: lambda result: lambda lines: ite(
        lt(5, len(lines)),
            lambda: (lambda yy: (
                result.append(list((
                mapl(int, at1(at1(lines).split(unpack(__str11))).split(unpack(__str12))),
                ite(eq(at0(yy), unpack(__str13)),
                    lambda: ite(
                        eq(at1(yy), unpack(__str14)),
                        lambda: (_1, _0, _0),
                        lambda: (_0, int(at1(yy)), _0)),
                    lambda: (_0, 1, int(at1(yy)))),
                last_int(at(lines, 3)),
                last_int(at(lines, 4)),
                last_int(at(lines, 5)),
                list()))),
                self(self)(result)(tail7(lines)))
            )(tail(at1(at(lines, 2).split(unpack(__str15))).split())),
        lambda: ()))
times = lambda d, xs, ys: mapl(lambda ks: imod(sum(map(lambda tt: mul(at0(tt), at1(tt)),zip(ks, ys))), d), xs)
ns = lambda n, xs: mul((n, ),len(xs))
test = lambda xs, ys: mapl(lambda ww: eq(imod(at0(ww), at1(ww)), _0), zip(xs, ys))

round = lambda monkeys, d: mapl(
    lambda m: (
        (lambda next: mapl(
            lambda zz: at0(at(monkeys, at(m, sub(4, at1(zz))))).append(at0(zz)),
            zip(next, test(next, ns(at(m, 2), next)))))(mapl(at0(xx), times(d, zip(map(s(curry(mul))(i), at0(m)), at0(m), ns(1, at0(m))), at1(m)))),
        at(m, 5).append(len(at0(m))),
        at0(m).clear()),
    monkeys)

(lambda monkeys: (
    read(monkeys)(list(ii(__str9).stdin)),
    mapl(lambda xxx: round(monkeys, ii(__str17).lcm(*mapl(lambda bv: at(bv, 2), monkeys))), range(at1(xx))),
    print((lambda maxes: mul(at0(maxes),at1(maxes)))(fix(
        lambda self: lambda acc: lambda xs: ite(
        eq(len(xs), _0),
        lambda: acc,
        lambda: (lambda cont:
            ite(
                lt(at0(xs), at0(acc)),
                lambda: cont(acc),
                lambda: ite(
                    lt(at0(xs), at1(acc)),
                    lambda: cont((at0(xs), at1(acc))),
                    lambda: cont((at1(acc), at0(xs)))
                )

            )
        )(lambda new_acc: self(self)(new_acc)(tail(xs)))
    )
    )((0, 0))(mapl(lambda www:sum(at(www, 5)), monkeys))))
))(list())
