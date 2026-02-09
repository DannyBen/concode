Concode
==================================================

![repocard](https://repocard.dannyben.com/svg/concode.svg)

Generate *consistent-codenames* from any string (Heroku style, aka Haiku).

This is a Ruby port of Python's [codenamize][1].

---

Installation
--------------------------------------------------

    $ gem install concode


Feature Highlights
--------------------------------------------------

- Use as a Ruby library or from the command line
- Generate heroku-style / docker-style consistent codenames from any string (e.g. IP address, git commit 
  hash)
- Control the number of words, and number of letters in each word
- Compatibility with Python's codenamize (both libraries will generate the 
  same codes given the same string)
- Limitless combinations (over 1.7 million for 2 words, and 1.8 billion for 3 
  words)


Command Line Usage
--------------------------------------------------

```shell
$ concode --help

Usage:
  concode <string> [options]
  concode --random [options]
  concode --count [options]
  concode (-h|--help|-v|--version)

Options:
  -w, --words N        Number of words to generate
  -c, --chars N        Max characters per word
  -g, --glue CHAR      Word separator
  -C, --caps           Capitalize words
  -n, --count          Count possible combinations
  -r, --random         Generate a random code
  -h, --help           Show this message
  -v, --version        Show version
```

### Examples

```shell
$ concode hello
plausible-term

$ concode hello --words 3
ancient-plausible-term

$ concode hello --words 3 --chars 3 --caps --glue ' '
Cut Red Bar

$ concode --random -w4
cruel-aggressive-cute-world
```


Library Usage
--------------------------------------------------

```ruby
require 'concode'

# basic use:

generator = Concode::Generator.new
puts generator.generate 'something annoying'
# => annoyed-poem

# or, with all the options:

generator = Concode::Generator.new words: 3, chars: 4, capitalize: true, glue: ' '
puts generator.generate 'something annoying'
# => Wise Rude Boot

# get the available combinations with:

puts generator.word_count
# => 7402200
```


Credits
--------------------------------------------------

Thanks to Jose Juan Montes ([@jjmontesl][2]) for developing and documenting 
[codenamize][1].


[1]: https://github.com/jjmontesl/codenamize
[2]: https://github.com/jjmontesl
