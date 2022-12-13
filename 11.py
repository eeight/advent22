im = __import__
es = str()
l = list

i = lambda x: x
k = lambda k: lambda _: k
s = lambda f: lambda g: lambda x: f(x)(g(x))

seq = lambda x, y: y

mapl = lambda f, xs: list(map(f, xs))
thunk = lambda x:lambda:x

fix = lambda f: f(f)

super = lambda f, g: lambda x: f(g(x))

plus = lambda x, y: sum((x, y))

_0 = len(())
_1 = len(((),))
__1 = es.find(chr(_1))
nn = lambda x: abs(plus(__1, bool(x)))
_2 = plus(_1, _1)
_3 = plus(_2, _1)
_4 = plus(_2, _2)
_5 = plus(_3, _2)

at0 = super(next, iter)
at1 = lambda xs: (lambda i: (lambda j: next(i))(next(i)))(iter(xs))

def callif(cond, f):
    if cond:
        f()

badmul = lambda x, k: (lambda l:
    seq(
        fix(lambda self:
            lambda acc, k:
                callif(
                    k,
                    lambda:
                    seq(
                        l.insert(_0, acc),
                        self(self)(plus(acc, x), plus(k, __1))
                    )
                )
        )(x, k),
        at0(l))
)(l((0,)))

pow = lambda x, k: (lambda l:
    seq(
        fix(lambda self:
            lambda acc, k:
                callif(
                    k,
                    lambda:
                    seq(
                        l.insert(_0, acc),
                        self(self)(badmul(acc, x), plus(k, __1))
                    )
                )
        )(x, k),
        at0(l))
)(l((1,)))

bind_2nd = lambda f, y: lambda x: f(x, y)

unpack = lambda x: es.join((lambda r: (lambda j: r)(fix(lambda self: lambda r, n: (lambda cond, f: any(map(lambda f: f(), (lambda: nn(cond), lambda: k(True)(f())))))(n, lambda: (lambda x: (r.append(chr(plus(at1(x), 32))), self(self)(r, at0(x))))(divmod(n, 90)),))(r, x)))(l()))

_4 = sum((_3, _1))
_6 = sum((_5, _1))
_7 = sum((_5, _2))
_8 = sum((_5, _3))
_9 = sum((_5, _3, _1))
_10 = sum((_5, _5))
_11 = sum((_5, _5, _1))
_12 = sum((_5, _5, _2))
_13 = sum((_5, _5, _3))
_14 = sum((_5, _5, _3, _1))
_15 = sum((_5, _5, _5))
_16 = sum((_5, _5, _5, _1))
_17 = sum((_5, _5, _5, _2))
_18 = sum((_5, _5, _5, _3))
_19 = sum((_5, _5, _5, _3, _1))
_20 = sum((_5, _5, _5, _5))
_21 = sum((_5, _5, _5, _5, _1))
_22 = sum((_5, _5, _5, _5, _2))
_23 = sum((_5, _5, _5, _5, _3))
_24 = sum((_5, _5, _5, _5, _3, _1))
_25 = pow(_5, _2)
_26 = sum((pow(_5, _2), _1))
_29 = sum((pow(_5, _2), _3, _1))
_7359 = sum((pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _3, _1))
_7636 = sum((pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), _5, _5, _1))
_542333 = sum((pow(_5, _8), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _3))
_557719 = sum((pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _5, _5, _3, _1))
_623327 = sum((pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _2))
_680393 = sum((pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), _5, _5, _5, _3))
_50218903 = sum((pow(_5, _11), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _3), pow(_5, _2), _3))
_53174327 = sum((pow(_5, _11), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _2))
_63276545 = sum((pow(_5, _11), pow(_5, _10), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _2), _5, _5, _5, _5))
_41333960243681 = sum((pow(_5, _19), pow(_5, _19), pow(_5, _17), pow(_5, _17), pow(_5, _17), pow(_5, _17), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _14), pow(_5, _14), pow(_5, _12), pow(_5, _12), pow(_5, _12), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _10), pow(_5, _10), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _7), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), _5, _1))
_3964518755594179 = sum((pow(_5, _22), pow(_5, _21), pow(_5, _21), pow(_5, _21), pow(_5, _20), pow(_5, _19), pow(_5, _19), pow(_5, _18), pow(_5, _18), pow(_5, _18), pow(_5, _18), pow(_5, _17), pow(_5, _16), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _14), pow(_5, _13), pow(_5, _13), pow(_5, _13), pow(_5, _12), pow(_5, _12), pow(_5, _12), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), _3, _1))
_373729995401202973 = sum((pow(_5, _25), pow(_5, _24), pow(_5, _23), pow(_5, _22), pow(_5, _21), pow(_5, _21), pow(_5, _21), pow(_5, _20), pow(_5, _20), pow(_5, _20), pow(_5, _19), pow(_5, _19), pow(_5, _19), pow(_5, _19), pow(_5, _18), pow(_5, _16), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _14), pow(_5, _14), pow(_5, _13), pow(_5, _13), pow(_5, _12), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _8), pow(_5, _8), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _5, _5, _5, _3))
_373729995401202973 = sum((pow(_5, _25), pow(_5, _24), pow(_5, _23), pow(_5, _22), pow(_5, _21), pow(_5, _21), pow(_5, _21), pow(_5, _20), pow(_5, _20), pow(_5, _20), pow(_5, _19), pow(_5, _19), pow(_5, _19), pow(_5, _19), pow(_5, _18), pow(_5, _16), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _14), pow(_5, _14), pow(_5, _13), pow(_5, _13), pow(_5, _12), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _8), pow(_5, _8), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _5, _5, _5, _3))

curry = lambda f: lambda x: lambda y: f(x, y)
gg = curry(getattr)
ga = lambda x, y: super(gg(x), unpack)(y)
ii = super(im, unpack)

op = ii(_3964518755594179)
at = ga(op, _41333960243681)
tail = bind_2nd(at, slice(_1, _7636))
tail7 = bind_2nd(at, slice(7, _7636))

sub = ga(op, _542333)
mul = ga(op, _623327)
div = ga(op, _373729995401202973)
eq = ga(op, _7359)
lt = ga(op, _7636)
imod = ga(op, _50218903)

ite = lambda i, t, e: at((e, t), i)()

xx = ite(eq(at1(ga(ii(_680393), _63276545)), str(_1)), thunk((bind_2nd(div, _3), 20)), thunk((i, 10000)))

last_int = lambda x: int(at(x.split(), __1))

ns = lambda n, xs: mul((n, ),len(xs))

(lambda monkeys: (
    fix(lambda self: lambda result: lambda lines: ite(
        lt(5, len(lines)),
            lambda: (lambda yy: (
                result.append(l((
                mapl(int, at1(at1(lines).split(unpack(_26))).split(unpack(_12))),
                ite(eq(at0(yy), unpack(_10)),
                    lambda: ite(
                        eq(at1(yy), unpack(_557719)),
                        lambda: (_1, _0, _0),
                        lambda: (_0, int(at1(yy)), _0)),
                    lambda: (_0, _1, int(at1(yy)))),
                last_int(at(lines, _3)),
                last_int(at(lines, 4)),
                last_int(at(lines, 5)),
                l()))),
                self(self)(result)(tail7(lines)))
            )(tail(at1(at(lines, 2).split(unpack(_29))).split())),
        lambda: ()))(monkeys)(l(ii(_680393).stdin)),
    mapl(lambda xxx: (lambda monkeys, d: mapl(
    lambda m: (
        (lambda next: mapl(
            lambda zz: at0(at(monkeys, at(m, sub(4, at1(zz))))).append(at0(zz)),
            zip(next, (lambda xs, ys: mapl(lambda ww: eq(imod(at0(ww), at1(ww)), _0), zip(xs, ys)))(next, ns(at(m, 2), next)))))(mapl(at0(xx), (lambda d, xs, ys: mapl(lambda ks: imod(sum(map(lambda tt: mul(at0(tt), at1(tt)),zip(ks, ys))), d), xs))(d, zip(map(s(curry(mul))(i), at0(m)), at0(m), ns(_1, at0(m))), at1(m)))),
        at(m, 5).append(len(at0(m))),
        at0(m).clear()),
    monkeys))(monkeys, ii(_53174327).lcm(*mapl(lambda bv: at(bv, 2), monkeys))), range(at1(xx))),
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
    )((_0, _0))(mapl(lambda www:sum(at(www, 5)), monkeys))))
))(l())
