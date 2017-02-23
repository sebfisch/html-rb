require 'minitest/autorun'
require 'html'

class HTMLTest < Minitest::Test
  def test_empty_doc
    assert_equal '<!doctype html><html></html>',
      HTML.doc {}
  end

  def test_nonempty_doc
    assert_equal '<!doctype html><html lang="en">'+
      '<head><title>Hello</title></head>'+
      '<body><h1 class="title">Hello &lt;HTML&gt;</h1></body></html>',
      HTML.doc(lang: 'en') {
        head { title { text 'Hello' } }
        body { h1(class: 'title') { text 'Hello <HTML>' } }
      }
  end

  def test_empty_fragment
    assert_equal '', HTML.fragment {}
  end

  def test_nonempty_fragment
    assert_equal '<li>1</li><li>2</li><li>3</li>',
      HTML.fragment { (1..3).each { |n| li { text n } } }
  end

  def test_ignore_unclosed_content
    assert_equal '<img>',
      HTML.fragment { img { text 'ignored' } }
  end
end
