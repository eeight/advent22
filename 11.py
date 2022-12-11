ii = __import__

i = lambda x: x
k = lambda k: lambda _: k
s = lambda f: lambda g: lambda x: f(x)(y(x))
l0 = list()

ite = lambda i, t, e: [e, t][i]()

xx = ite(False, lambda: (lambda x: x // 3, 20), lambda: (i, 10000))

last_int = lambda x: int(x.split()[-1])

fix = lambda f: f(f)

mapl = lambda f, xs: list(map(f, xs))
sqr = lambda x: x*x

read_f = lambda self: lambda result: lambda lines: ite(
        len(lines) > 5,
            lambda: (lambda yy: (
                result.append([
                mapl(int, lines[1].split(": ")[1].split(", ")),
                ite(yy[0] == '*',
                    lambda: ite(
                        yy[1] == 'old',
                        lambda: [1, 0, 0],
                        lambda: [0, int(yy[1]), 0]),
                    lambda: [0, 1, int(yy[1])]),
                last_int(lines[3]),
                last_int(lines[4]),
                last_int(lines[5]),
                []]),
                self(self)(result)(lines[7:]))
            )(lines[2].split("= ")[1].split()[1:]),
        lambda: None)

read = fix(read_f)
times = lambda d, xs, ys: mapl(lambda ks: sum(map(lambda tt: tt[0]*tt[1],zip(ks, ys))) % d, xs)
ns = lambda n, xs: [n]*len(xs)
test = lambda xs, ys: mapl(lambda ww: ww[0] % ww[1] == 0, zip(xs, ys))

round = lambda monkeys, d: mapl(
    lambda m: (
        (lambda next: mapl(
            lambda zz: monkeys[ite(zz[1], lambda: m[3], lambda: m[4])][0].append(zz[0]),
            zip(next, test(next, ns(m[2], next)))))(mapl(xx[0], times(d, zip(map(sqr, m[0]), m[0], ns(1, m[0])), m[1]))),
        m[5].append(len(m[0])),
        m[0].clear()),
    monkeys)

(lambda monkeys: (
    read(monkeys)(list(ii("sys").stdin)),
    mapl(lambda xxx: round(monkeys, ii("math").lcm(*mapl(lambda bv: bv[2], monkeys))), range(xx[1])),
    print((lambda maxes: maxes[0]*maxes[1])(fix(
        lambda self: lambda acc: lambda xs: ite(
        len(xs) == 0,
        lambda: acc,
        lambda: (lambda cont:
            ite(
                xs[0] < acc[0],
                lambda: cont(acc),
                lambda: ite(
                    xs[0] < acc[1],
                    lambda: cont([xs[0], acc[1]]),
                    lambda: cont([acc[1], xs[0]])
                )

            )
        )(lambda new_acc: self(self)(new_acc)(xs[1:]))
    )
    )([-2, -1])(mapl(lambda www:sum(www[5]), monkeys))))
))(list())
