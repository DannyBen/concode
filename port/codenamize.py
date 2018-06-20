# codenamize module
# Generate consistent easier-to-remember codenames from strings and numbers.
# Jose Juan Montes 2015-2016 - MIT License
import six
import argparse
import hashlib
import functools
import sys

ADJECTIVES = ["aback","abaft","abandoned","abashed","aberrant"]
NOUNS = ["a","ability","abroad","abuse","access","accident","account"]


# Sort by length and cache list ranges
ADJECTIVES.sort(key=lambda x: len(x))
NOUNS.sort(key=lambda x: len(x))
ADJECTIVES_LENGTHS = { l: sum(1 for a in ADJECTIVES if len(a) <= l) for l in (3, 4, 5, 6, 7, 8, 9) }
NOUNS_LENGTHS = { l: sum(1 for a in NOUNS if len(a) <= l) for l in (3, 4, 5, 6, 7, 8, 9) }

def codenamize_particles(obj = None, adjectives = 1, max_item_chars = 0, hash_algo = 'md5'):
    # Minimum length of 3 is required
    if max_item_chars > 0 and max_item_chars < 3:
        max_item_chars = 3
    if max_item_chars > 9:
        max_item_chars = 0


    # Prepare codename word lists and calculate size of codename space
    particles = [ NOUNS ] + [ ADJECTIVES for _ in range(0, adjectives) ]
    if max_item_chars > 0:
        particles[0] = NOUNS[:NOUNS_LENGTHS[max_item_chars]]
        particles[1:] = [ ADJECTIVES[:ADJECTIVES_LENGTHS[max_item_chars]] for _ in range(0, adjectives) ]

    total_words = functools.reduce(lambda a, b: a * b, [len(p) for p in particles], 1)

    # Return size of codename space if no object is passed
    if obj is None:
        return total_words

    # Convert numbers to strings
    if isinstance(obj, six.integer_types):
        obj = str(obj)

    if isinstance(obj, six.text_type):
        obj = obj.encode('utf-8')

    hh = hashlib.new(hash_algo)
    hh.update(obj)
    obj_hash = int(hh.hexdigest(), 16) * 36413321723440003717

    # Calculate codename words
    index = obj_hash % total_words

    codename_particles = []
    for p in particles:
        codename_particles.append(p[(index) % len(p)])
        index = int(index / len(p))


    codename_particles.reverse()

    return codename_particles

def codenamize_space(adjectives, max_item_chars, hash_algo = 'md5'):
    return codenamize_particles(None, adjectives, max_item_chars, hash_algo)


def codenamize(obj, adjectives = 1, max_item_chars = 0, join = "-", capitalize = False, hash_algo = 'md5'):
    codename_particles = codenamize_particles(obj, adjectives, max_item_chars, hash_algo)

    if join is None:
        join = ""
    if capitalize:
        codename_particles = [ p[0].upper() + p[1:] for p in codename_particles]

    codename = join.join(codename_particles)

    return codename


def print_test():
    """
    Test and example function for the "codenamize" module.
    """
    print("OBJ       ADJ0-MAX5    ADJ1-MAX5         ADJ2-MAX5  ADJ-0, ADJ-1, ADJ-2 (capitalized, empty join character)")
    for v in range(100001, 100010):
        print("%6s  %11s  %11s %17s  %s, %s, %s" % (v, codenamize(v, 0, 5), codenamize(v, 1, 5), codenamize(v, 2, 5),
                                                    codenamize(v, 0, 0, "", True), codenamize(v, 1, 0, "", True), codenamize(v, 2, 0, "", True)))

    print("codenamize SPACE SIZES")
    for a in range(0, 3):
        for m in (3, 4, 5, 6, 7, 0):
            print("%d adj (max %d chars) = %d combinations" % (a, m, codenamize_space(a, m)))

    print("TESTS")
    l1 = list(set( [ codenamize(a, 1, 3) for a in range(0, 2760 + 17) ] ))
    l2 = list(set( [ codenamize(a, 2, 3) for a in range(0, 66240 + 17) ] ))
    print("  (*, 1 adj, max 3) => %d distinct results (space size is %d)" % (len(l1), codenamize_space(1, 3)))
    print("  (*, 2 adj, max 3) => %d distinct results (space size is %d)" % (len(l2), codenamize_space(2, 3)))
    print("  (100001, 1 adj, max 5) => %s (must be 'funny-boat')" % (codenamize(100001, 1, 5)))
    print("  ('100001', 1 adj, max 5) => %s (must be 'funny-boat')" % (codenamize('100001', 1, 5)))
    print("  (u'100001', 1 adj, max 5) => %s (must be 'funny-boat')" % (codenamize(u'100001', 1, 5)))


def main():

    parser = argparse.ArgumentParser(description='Generate consistent easier-to-remember codenames from strings and numbers.')
    parser.add_argument('strings', nargs='*', help="One or more strings to codenamize.")
    parser.add_argument('-p', '--prefix', dest='prefix', action='store', type=int, default=1, help='number of prefixes to use')
    parser.add_argument('-m', '--maxchars', dest='maxchars', action='store', type=int, default=0, help='max word characters (0 for no limit)')
    parser.add_argument('-a', '--hash_algorithm', dest='hash_algo', action='store', type=str, default = 'md5',
                        help='the algorithm to use to hash the input value')
    parser.add_argument('-j', '--join', dest='join', action='store', default="-", help='separator between words (default: -)')
    parser.add_argument('-c', '--capitalize', dest='capitalize', action='store_true', help='capitalize words')
    parser.add_argument('--space', dest='space', action='store_true', help='show codename space for the given arguments')
    parser.add_argument('--tests', dest='tests', action='store_true', help='show information and samples')
    parser.add_argument('--list_algorithms', dest='list_algorithms', action='store_true',
                        help='List the hash algorithms available')
    parser.add_argument('--version', action='version', version='codenamize %s' % ("1.2.2"))

    args = parser.parse_args()

    if args.list_algorithms:
        for a in hashlib.algorithms:
            print(a)
        return

    if args.tests:
        print_test()
        return

    if args.space:
        print(codenamize_space(args.prefix, args.maxchars, args.hash_algo))
        return

    if len(args.strings) == 0:
        parser.print_usage()
        return

    for o in args.strings:
        print(codenamize(o, args.prefix, args.maxchars, args.join, args.capitalize, args.hash_algo))


if __name__ == "__main__":
    main()
