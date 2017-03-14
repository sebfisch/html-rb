```ruby
HTML.doc {
  head { title { text 'README' } }
  body {
    h1 { text 'HTML in Ruby with Blocks' }
    p {
      text 'The html gem lets you define HTML documents using Ruby blocks. '
      text 'See the '
      a(href: 'https://sebfisch.github.io/html-rb/HTML.html') {
        text 'API docs'
      }
      text ' for details on how to use it.'
    }
  }
}
```

# HTML in Ruby with Blocks

The `html` gem lets you define HMTL documents using Ruby blocks. See the [API docs](https://sebfisch.github.io/html-rb/HTML.html) for details on how to use it.

## Installation

I have not yet published this gem to [RubyGems.org](http://rubygems.org/). You can download [html-0.1.3.gem](https://raw.githubusercontent.com/sebfisch/html-rb/master/html-0.1.3.gem) and install it from the downloaded file:

    gem install html-0.1.3.gem

You can also use the latest version of this gem in your project.
Just include this line in the `Gemfile`:

    gem "html", :git => "git://github.com/sebfisch/html-rb.git"

## Motivation

This gem is not the only way to generate HTML in Ruby programs. Its focus is on conceptual simplicity of both implementation and use. If you know Ruby blocks and have a basic understanding of HTML you should be able to learn quickly how to use this gem.

I use this gem for teaching to avoid conceptual complications as much as possible. The API is meant to be minimal but convenient and the implementation aims to be accessible to interested students who are no Ruby experts.

## Comparison

In using Ruby as source language this gem is similar to the HTML generating methods of Ruby's built-in [CGI](https://ruby-doc.org/stdlib/libdoc/cgi/rdoc/CGI.html#class-CGI-label-Generating+HTML) class and [Markaby](https://github.com/whymirror/markaby) by why the lucky stiff. This gem is somewhere in between those other methods. Using it is more convenient than using the CGI class, because the object providing the HTML generating methods [is omitted](https://github.com/whymirror/markaby#a-note-about-instance_eval) just like with Markaby. On the other hand, its implementation is less sophisticated than Markaby's. I recommend using Markaby, unless you can do without the additional convenience (such as special treatment for `class` and `id` attributes) its more sophisticated implementation provides.

© 2017, Sebastian Fischer, MIT license
