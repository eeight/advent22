import sys
import re
from collections import defaultdict

builtins = "print clear zip range int split stdin slice append divmod bool getattr abs map any __import__ sum next iter bool list lambda join insert str len lcm find chr".split()

stats = defaultdict(int)

class Mangler:
    def __init__(self):
        self.names = {x: x for x in builtins}
        self.name_index = 0

    def fill_from_stats(self):
        kvs = list(stats.items())
        kvs.sort(key=lambda x: x[1], reverse=True)
        for k, _ in kvs:
            if k not in self.names:
                self.names[k] = self.next_name()

    def next_name(self):
        i = self.name_index
        self.name_index += 1
        charset = "_ilIo"
        result = []
        while True:
            result.append(charset[i % len(charset)])
            i //= len(charset)
            if i == 0:
                break

        return "".join(result)

    def mangle(self, str):
        def callback(match):
            t = match.group()
            if t not in self.names:
                self.names[t] = self.next_name()
            stats[t] += 1
            return self.names[t]

        return re.sub(r'[_\w][_\w\d]*', callback, str)

def desugar(lines, do_print, mangler):
    stack = []
    for line in lines:
        line = mangler.mangle(line.strip())
        if len(line) == 0:
            continue
        if "=" not in line:
            do_print(line)
            continue
        var, expr = line.split(" = ")
        do_print(f"(lambda {var}:")
        stack.append(expr)

    do_print("".join(f")({expr})" for expr in stack[::-1]))

lines = list(sys.stdin)
desugar(lines, lambda x: None, Mangler())
m = Mangler()
m.fill_from_stats()
pieces = []
desugar(lines, lambda x: pieces.append(x), m)

print("".join(pieces).replace(" ", "").replace("lambda", "lambda ").replace(" :", ":"))
