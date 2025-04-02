import sys

if len(sys.argv) < 2:
    print('python3 gen_explorer_input.py [filename.csv]')
else:
    filename = sys.argv[1]

    with open(filename, 'r', encoding='utf-8') as file:
        addrs = [ addr.strip() for addr in file ]
        print(addrs)
