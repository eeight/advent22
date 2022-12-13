import sys
import re

builtins = "print clear zip range int split stdin slice append divmod bool getattr abs map any __import__ sum next iter bool list lambda join insert str len lcm find chr".split()

class Mangler:
    def __init__(self):
        self.names = {x: x for x in builtins}
        self.name_index = 0

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
            if self.names[t] == xxx:
                print(t, file=sys.stderr)
            return self.names[t]

        return re.sub(r'[_\w][_\w\d]*', callback, str)

def desugar(lines):
    mangler = Mangler()
    stack = []
    for line in lines:
        line = mangler.mangle(line.strip())
        if len(line) == 0:
            continue
        if "=" not in line:
            print(line)
            continue
        var, expr = line.split(" = ")
        print(f"(lambda {var}:")
        stack.append(expr)

    print("".join(f")({expr})" for expr in stack[::-1]))

desugar(sys.stdin)
