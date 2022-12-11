ii = __import__

bind_2nd = lambda f, y: lambda x: f(x, y)
op = ii("operator")
at = getattr(op, "getitem")
_0 = len(list())
_1 = 1 # XXX
at0 = bind_2nd(at, _0)
at1 = bind_2nd(at, _1)
tail = bind_2nd(at, slice(1, 999))
tail7 = bind_2nd(at, slice(7, 999))


i = lambda x: x
k = lambda k: lambda _: k
s = lambda f: lambda g: lambda x: f(x)(y(x))
l0 = list()

ite = lambda i, t, e: at((e, t), i)()

# ite = \i t e . ap (at (tuple e t) i) None
# ite = \e . (at (tuple e t) i) (K None)
# ite = S (\e. at (tuple e t) i) (K None)
# \e. (at (tuple e t)) i
# S (\e. at (tuple e t)) (K i)
# S (S (K at) (S (S (K tuple) I) (K t))) (K i)
lambda i, t, e: at((e, t), i)()


xx = ite(False, lambda: (lambda x: x // 3, 20), lambda: (i, 10000))

last_int = lambda x: int(at(x.split(), -1))

fix = lambda f: f(f)

mapl = lambda f, xs: list(map(f, xs))
sqr = lambda x: x*x

read_f = lambda self: lambda result: lambda lines: ite(
        len(lines) > 5,
            lambda: (lambda yy: (
                result.append(list((
                mapl(int, at1(at1(lines).split(": ")).split(", ")),
                ite(at0(yy) == "*",
                    lambda: ite(
                        at1(yy) == "old",
                        lambda: (_1, _0, _0),
                        lambda: (_0, int(at1(yy)), _0)),
                    lambda: (_0, 1, int(at1(yy)))),
                last_int(at(lines, 3)),
                last_int(at(lines, 4)),
                last_int(at(lines, 5)),
                list()))),
                self(self)(result)(tail7(lines)))
            )(tail(at1(at(lines, 2).split("= ")).split())),
        lambda: None)

read = fix(read_f)
times = lambda d, xs, ys: mapl(lambda ks: sum(map(lambda tt: at0(tt)*at1(tt),zip(ks, ys))) % d, xs)
ns = lambda n, xs: (n, )*len(xs)
test = lambda xs, ys: mapl(lambda ww: at0(ww) % at1(ww) == _0, zip(xs, ys))

round = lambda monkeys, d: mapl(
    lambda m: (
        (lambda next: mapl(
            lambda zz: at0(at(monkeys, at(m, 4 - at1(zz)))).append(at0(zz)),
            zip(next, test(next, ns(at(m, 2), next)))))(mapl(at0(xx), times(d, zip(map(sqr, at0(m)), at0(m), ns(1, at0(m))), at1(m)))),
        at(m, 5).append(len(at0(m))),
        at0(m).clear()),
    monkeys)

(lambda monkeys: (
    read(monkeys)(list(ii("sys").stdin)),
    mapl(lambda xxx: round(monkeys, ii("math").lcm(*mapl(lambda bv: at(bv, 2), monkeys))), range(at1(xx))),
    print((lambda maxes: at0(maxes)*at1(maxes))(fix(
        lambda self: lambda acc: lambda xs: ite(
        len(xs) == _0,
        lambda: acc,
        lambda: (lambda cont:
            ite(
                at0(xs) < at0(acc),
                lambda: cont(acc),
                lambda: ite(
                    at0(xs) < at1(acc),
                    lambda: cont((at0(xs), at1(acc))),
                    lambda: cont((at1(acc), at0(xs)))
                )

            )
        )(lambda new_acc: self(self)(new_acc)(tail(xs)))
    )
    )((-2, -1))(mapl(lambda www:sum(at(www, 5)), monkeys))))
))(list())
