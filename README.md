Concode
==================================================

---

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
$ concode
Usage: concode <string> [options]

Options:
  -w, --words N        Number of words to generate
  -c, --chars N        Max characters per word
  -g, --glue CHAR      Word separator
  -C, --caps           Capitalize words
  -h, --help           Show this message
      --version        Show version
```

### Examples

```shell
$ concode hello
plausible-term

$ concode hello --words 3
ancient-plausible-term

$ concode hello --words 3 --chars 3 --caps --glue ' '
Cut Red Bar
```


Library Usage
--------------------------------------------------

```ruby
require 'concode'

# Basic use:

generator = Concode::Generator.new
puts generator.generate 'something annoying'
# => annoyed-poem

# Or, with all the options:

generator = Concode::Generator.new words: 3, chars: 4, capitalize: true, glue: ' '
puts generator.generate 'something annoying'
# => Wise Rude Boot
```


Credits
--------------------------------------------------

Thanks to Jose Juan Montes ([@jjmontesl][2]) for developing and documenting 
[codenamize][1].


[1]: https://github.com/jjmontesl/codenamize
[2]: https://github.com/jjmontesl
