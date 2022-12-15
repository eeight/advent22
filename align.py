import sys

def is_id(c):
    return c.isalpha() or c == "_"

class Chunker:
    def __init__(self, text):
        self.text = text + "$"

    def give(self, n):
        i = n - 1
        while i + 1 < len(self.text):
            if is_id(self.text[i]) and is_id(self.text[i + 1]):
                i += 1
            else:
                break

        result = self.text[:i + 1]
        self.text = self.text[i + 1:]
        return result

text = sys.stdin.read()
ch = Chunker(text)

def find_pieces(line):
    i = line.find('#')
    j = line.find('.', i + 1)
    k = line.find('#', j)
    if k < 0:
        return [(i, j)]
    l = line.find('.', k + 1)
    return [(i, j), (k, l)]

for line in open(sys.argv[1]):
    l = []
    pos = 0
    for (b, e) in find_pieces(line):
        chunk = ch.give(e - b)
        real_b = b - (len(chunk) - (e - b)) // 2
        l.append(" "*(real_b - pos))
        l.append(chunk)
        pos = real_b + len(chunk)

    print("".join(l))
