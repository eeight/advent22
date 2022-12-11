ii = __import__

if False:
    post_proc = lambda x: x // 3
    iter = 20
else:
    post_proc = lambda x: x
    iter = 10000

def read(lines, result):
    if len(lines) >= 6:
        result[0].append([int(x) for x in lines[1].split(": ")[1].split(", ")])
        op, arg = lines[2].split("= ")[1].split()[1:]
        if op == '*':
            if arg == 'old':
                k = [1, 0, 0]
            else:
                k = [0, int(arg), 0]
        else:
            k = [0, 1, int(arg)]
        op = (lambda x, y: x*y) if op == '*' else (lambda x, y: x + y)
        argf = (lambda x: x) if arg == "old" else (lambda _: int(arg))
        d = int(lines[3].split()[-1])
        t = int(lines[4].split()[-1])
        e = int(lines[5].split()[-1])
        result[1].append(k)
        result[2].append(d)
        result[3].append(t)
        result[4].append(e)
        read(lines[7:], result)

def sqr(xs):
    return [x*x for x in xs]

def times(d, xs, ys):
    return [sum(x1*x2 for x1, x2 in zip(x, ys)) % d for x in xs]

def ns(n, xs):
    return [n]*len(xs)

def test(xs, ys):
    return [x % y == 0 for x, y in zip(xs, ys)]

def round(monkeys, counts, d):
    for i in range(len(monkeys[0])):
        mm = monkeys[0][i]
        next = [post_proc(x) for x in times(d, zip(sqr(mm), mm, ns(1, mm)), monkeys[1][i])]
        t = test(next, ns(monkeys[2][i], next))
        jump = [monkeys[4][i], monkeys[3][i]]
        for j, r in enumerate(t):
            monkeys[0][jump[r]].append(next[j])
        counts[i] += len(monkeys[0][i])
        monkeys[0][i] = list()

monkeys = [[], [], [], [], []]
read(list(ii("sys").stdin), monkeys)
d = ii("math").lcm(*monkeys[2])
counts = ns(0, monkeys[0])

for i in range(iter):
    round(monkeys, counts, d)

print(counts)

x, y = sorted(counts, reverse=True)[:2]
print(x*y)
