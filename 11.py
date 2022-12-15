im,es,l,i,s,seq,mapl,thunk,fix,super,ss = __import__,str(),list,(lambda x: x),(lambda f: lambda g: lambda x: f(x)(g(x))),(lambda x, y: y),(lambda f, xs: list(map(f, xs))), (lambda x:lambda:x),(lambda f: f(f)),(lambda f, g: lambda x: f(g(x))),sum
plus,bind_2nd,curry = (lambda x, y: ss((x, y))),(lambda f, y: lambda x: f(x, y)),(lambda f: lambda x: lambda y: f(x, y))
_0,_1,at0,at1 = len(()),len(((),)),super(next, iter),lambda xs: (lambda i: (lambda j: next(i))(next(i)))(iter(xs))
__1,_2 = es.find(chr(_1)),plus(_1, _1)
_3,_4 = plus(_2, _1),plus(_2, _2)
_5 = plus(_3, _2)
callif = lambda cond, f: any(map(lambda f: f(), (lambda: (lambda x: abs(plus(__1, bool(x))))(cond), lambda: seq(f(), _1))))
badmul = (lambda x, k: (lambda l: seq( fix(lambda self: lambda acc, k: callif( k, lambda: seq( l.insert(_0, acc), self(self)(plus(acc, x), plus(k, __1)))))(x, k), at0(l)))(l((_0,))))
pow = lambda x, k: (lambda l: seq( fix(lambda self: lambda acc, k: callif( k, lambda: seq( l.insert(_0, acc), self(self)(badmul(acc, x), plus(k, __1)))))(x, k), at0(l)))(l((_1,)))
_6,_7,_8,_9,_10,_11,_12,_13,_14,_15,_16,_17,_18,_19,_20,_21,_22 = ss((_5, _1)),ss((_5, _2)),ss((_5, _3)),ss((_5, _3, _1)),ss((_5, _5)),ss((_5, _5, _1)),ss((_5, _5, _2)),ss((_5, _5, _3)),ss((_5, _5, _3, _1)),ss((_5, _5, _5)),ss((_5, _5, _5, _1)),ss((_5, _5, _5, _2)),ss((_5, _5, _5, _3)),ss((_5, _5, _5, _3, _1)),ss((_5, _5, _5, _5)),ss((_5, _5, _5, _5, _1)),ss((_5, _5, _5, _5, _2))
_7636,_680393 = ss((pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), _5, _5, _1)),ss((pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), _5, _5, _5, _3))
unpack,gg = (lambda x: es.join((lambda r: (lambda j: r)(fix(lambda self: lambda r, n: callif(n, lambda: (lambda x: (r.append(chr(plus(at1(x), pow(_2, _5)))), self(self)(r, at0(x))))(divmod(n, badmul(_9, _10))),))(r, x)))(l()))),curry(getattr)
ga,ii = lambda x, y: super(gg(x), unpack)(y),super(im, unpack)
op = ii(ss((pow(_5, _22), pow(_5, _21), pow(_5, _21), pow(_5, _21), pow(_5, _20), pow(_5, _19), pow(_5, _19), pow(_5, _18), pow(_5, _18), pow(_5, _18), pow(_5, _18), pow(_5, _17), pow(_5, _16), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _14), pow(_5, _13), pow(_5, _13), pow(_5, _13), pow(_5, _12), pow(_5, _12), pow(_5, _12), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), _3, _1)))
at = ga(op, ss((pow(_5, _19), pow(_5, _19), pow(_5, _17), pow(_5, _17), pow(_5, _17), pow(_5, _17), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _14), pow(_5, _14), pow(_5, _12), pow(_5, _12), pow(_5, _12), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _11), pow(_5, _10), pow(_5, _10), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _7), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), _5, _1)))

tail,tail7 = bind_2nd(at, slice(_1, _7636)),bind_2nd(at, slice(_7, _7636))
sub,mul,div,eq,lt,imod = ga(op, ss((pow(_5, _8), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _3))),ga(op, ss((pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _2))),ga(op, ss((pow(_5, pow(_5, _2)), pow(_5, ss((_5, _5, _5, _5, _3, _1))), pow(_5, ss((_5, _5, _5, _5, _3))), pow(_5, _22), pow(_5, _21), pow(_5, _21), pow(_5, _21), pow(_5, _20), pow(_5, _20), pow(_5, _20), pow(_5, _19), pow(_5, _19), pow(_5, _19), pow(_5, _19), pow(_5, _18), pow(_5, _16), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _15), pow(_5, _14), pow(_5, _14), pow(_5, _13), pow(_5, _13), pow(_5, _12), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _8), pow(_5, _8), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _5, _5, _5, _3))),ga(op, ss((pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _3, _1))),ga(op, _7636),ga(op, ss((pow(_5, _11), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _3), pow(_5, _2), _3)))
ite,lcm1 = (lambda i, t, e: at((e, t), i)()),ii(ss((pow(_5, _11), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _2))).lcm
xx,last_int,ns,lcm2 = ite(eq(at1(ga(ii(_680393), ss((pow(_5, _11), pow(_5, _10), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _2), _5, _5, _5, _5)))), str(_1)), thunk((bind_2nd(div, _3), _20)), thunk((i, pow(_10, _4)))),lambda x: int(at(x.split(), __1)),lambda n, xs: mul((n, ),len(xs)),fix(lambda self: lambda xs:ite(bool(xs), lambda: lcm1(at0(xs), self(self)(tail(xs))) , lambda: _1))
(lambda monkeys: (
    fix(lambda self: lambda result: lambda lines: ite(
        lt(_5, len(lines)),
            lambda: (lambda yy: (
                result.append(l((
                mapl(int, at1(at1(lines).split(unpack(ss((pow(_5, _2), _1))))).split(unpack(_12))),
                ite(eq(at0(yy), unpack(_10)),
                    lambda: ite(
                        eq(at1(yy), unpack(ss((pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _2), pow(_5, _2), pow(_5, _2), _5, _5, _5, _3, _1)))),
                        lambda: (_1, _0, _0),
                        lambda: (_0, int(at1(yy)), _0)),
                    lambda: (_0, _1, int(at1(yy)))),
                last_int(at(lines, _3)),
                last_int(at(lines, _4)),
                last_int(at(lines, _5)),
                l()))),
                self(self)(result)(tail7(lines)))
            )(tail(at1(at(lines, _2).split(unpack(ss((pow(_5, _2), _3, _1))))).split())),
        lambda: ()))(monkeys)(l(ga(ii(_680393), ss((pow(_5, _13), pow(_5, _13), pow(_5, _13), pow(_5, _13), pow(_5, _12), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _10), pow(_5, _9), pow(_5, _9), pow(_5, _8), pow(_5, _8), pow(_5, _8), pow(_5, _7), pow(_5, _7), pow(_5, _7), pow(_5, _6), pow(_5, _5), pow(_5, _5), pow(_5, _5), pow(_5, _4), pow(_5, _4), pow(_5, _4), pow(_5, _3), pow(_5, _3), pow(_5, _3), pow(_5, _2), pow(_5, _2), _5, _5, _5, _3))))),
    mapl(lambda xxx: (lambda monkeys, d: mapl(
    lambda m: (
        (lambda next: mapl(
            lambda zz: at0(at(monkeys, at(m, sub(_4, at1(zz))))).append(at0(zz)),
            zip(next, (lambda xs, ys: mapl(lambda ww: eq(imod(at0(ww), at1(ww)), _0), zip(xs, ys)))(next, ns(at(m, _2), next)))))(mapl(at0(xx), (lambda d, xs, ys: mapl(lambda ks: imod(ss(map(lambda tt: mul(at0(tt), at1(tt)),zip(ks, ys))), d), xs))(d, zip(map(s(curry(mul))(i), at0(m)), at0(m), ns(_1, at0(m))), at1(m)))),
        at(m, _5).append(len(at0(m))),
        at0(m).clear()),
    monkeys))(monkeys, lcm2(mapl(lambda bv: at(bv, _2), monkeys))), range(at1(xx))),
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
    )((_0, _0))(mapl(lambda www:ss(at(www, _5)), monkeys))))
))(l())
