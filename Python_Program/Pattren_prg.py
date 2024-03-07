def print_pattren(rows):
    for i in range(1, rows+1):
        for j in range(1, i+1):
            print('* ', end="")
        print()

    for k in range(rows+1, 0, -1):
        for l in range(1, k-1):
            print(' *', end="")
        print()

num = 4
print_pattren(num)