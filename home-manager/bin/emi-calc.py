import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--principal", type=float)
parser.add_argument("-r", "--rate", type=float)
parser.add_argument("-t", "--time", type=float)

args = parser.parse_args()

# EMI = [P x R x (1+R)^N] / [(1+R)^N - 1],
