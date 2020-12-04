t0 = 1023
t1 = 1
t4 = 63
s1 = 0
for s0 in range(t0):
    if s0 % 2 == 0:
        s1 -= s0
    else:
        s1 += s0
    t5 = s0 & 63
    print("D[%d] = %d" % (t5+64, s1))

t4 = 1
if(s1 < 0 or s1 > 511):
    t4 = 4

print("t0 = %d" % (t0 >> t4))
