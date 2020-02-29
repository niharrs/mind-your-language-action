import sys


def analyze_sentiment(author, comment):
    """
    Analyze the sentiment
    """
    if "bad" in comment:
        return -1
    elif "good" in comment:
        return 1
    else:
        return 0


if __name__ == "__main__":

    if len(sys.argv) != 3:
        raise RuntimeError("Wrong number of input.")

    author = sys.argv[1]
    comment = sys.argv[2]

    print(analyze_sentiment(author, comment))

