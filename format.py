top1 = (56, 0)
top2 = (87, 0)

bottom1 = (0, 98)
bottom2 = (145, 98)

hole_top = (69, 14)
hole_bottom1 = (30, 88)
hole_bottom2 = (100, 88)

def left_of(p1, p2, x):
    xrate = (p2[0] - p1[0]) / float(p2[1] - p1[1])
    dy = x[1] - p1[1]
    return x[0] < (p1[0] + dy*xrate)


area = 0
for y in range(0, bottom1[1] + 1):
    l = []
    for x in range(0, bottom2[0] + 1):
        p = (x, y)
        if (left_of(top2, bottom2, p) and not left_of(top1, bottom1, p)) and not (
                y < hole_bottom1[1] and
                left_of(hole_top, hole_bottom2, p) and not left_of(hole_top, hole_bottom1, p)):
            l.append('#')
            area += 1
        else:
            l.append('.')

    print("".join(l))

print(f"{area=}")
