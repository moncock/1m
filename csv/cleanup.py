import sys
from pprint import pprint as pp
from web3.utils.address import to_checksum_address

if len(sys.argv) < 2:
    print('python3 cleanup.py [filename.csv]')
else:
    filename = sys.argv[1]

    with open(filename, 'r', encoding='utf-8') as file:
        addrs = [ addr.strip().lower() for addr in file ]
        addrs = set(addrs)
        addrs = sorted(addrs)
        addrs = [ to_checksum_address(addr) for addr in addrs ]

    # output
    for addr in addrs:
        print(addr)
