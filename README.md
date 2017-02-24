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
    h2 { text 'Installation' }
    p {
      text 'I have not yet published this gem to '
      a(href: 'http://rubygems.org/') { text 'RubyGems.org' }
      text '. You can download '
      a(href: 'https://raw.githubusercontent.com/sebfisch/html-rb/master/html-0.1.1.gem') {
        text 'html-0.1.1.gem'
      }
      text ' and install it from the downloaded file:'
    }
    pre {
      inline 'gem install html-0.1.1.gem'
    }
    p {
      text 'You can also use the latest version of this gem in you project. '
      text 'Just include this line in the Gemfile:'
    }
    pre {
      inline 'gem "html", :git => "git://github.com/sebfisch/html-rb.git"'
    }
  }
}
```

# HTML in Ruby with Blocks

The `html` gem lets you define HMTL documents using Ruby blocks. See the [API docs](https://sebfisch.github.io/html-rb/HTML.html) for details on how to use it.

## Installation

I have not yet published this gem to [RubyGems.org](http://rubygems.org/). You can download [html-0.1.1.gem](https://raw.githubusercontent.com/sebfisch/html-rb/master/html-0.1.1.gem) and install it from the downloaded file:

    gem install html-0.1.1.gem

You can also use the latest version of this gem in your project by including this line in the `Gemfile`:

    gem "html", :git => "git://github.com/sebfisch/html-rb.git"
