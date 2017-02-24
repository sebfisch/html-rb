require 'htmlentities'

# This package lets you define HTML documents (and fragments of documents)
# by using Ruby blocks. The following example shows a simple HTML document:
#
#   HTML.doc(lang: 'en') {
#     head { title { text 'Hello' } }
#     body { h1 { text 'Hello <HTML>' } }
#   }
#
# This expression evaluates to the following string:
#
#   '<!doctype html>' +
#   '<html lang="en">' +
#     '<head><title>Hello</title></head>' +
#     '<body>' +
#       '<h1>Hello &lt;HTML&gt;</h1>' +
#     '</body>' +
#   '</html>'
#
# Special characters are replaced with corresponding HTML entities. For example,
# <tt>text 'Hello <HTML>'</tt> outputs <tt>Hello &lt;HTML&gt;</tt> in the
# corresponding HTML document. To avoid automatic replacement, you can use
# <tt>inline</tt> instead of <tt>text</tt>.
#
# Like the <tt>lang</tt> attribute above, attributes to other tags are defined
# using named parameters. For example, here is a link:
#
#   a(href: 'http://rubygems.org/gems/html') {
#     text 'The HTML Gem'
#   }
#
# HTML fragments can be defined using loops or other Ruby constructs:
#
#   colors = ['Maroon', 'Teal', 'DarkSlateBlue']
#   ul {
#     colors.each do |color|
#       li(style: 'color: ' + color) { text color }
#     end
#   }
#
# We can use HTML.fragment to abstract this definition into a function that
# accepts arbitrary colors.
#
#   def color_list colors
#     HTML.fragment {
#       ul {
#         colors.each do |color|
#           li(style: 'color: ' + color) { text color }
#         end
#       }
#     }
#   end
#
# The methods used to describe HTML elements are only visible inside blocks
# passed to HTML.doc or HTML.fragment. Here we use HTML.fragment, which does
# not generate <tt><html></tt> tags and supports multiple elements next to each
# other as output. We can include a list of colors in an HTML document using
# <tt>inline</tt>:
#
#   inline color_list ['Maroon', 'Teal', 'DarkSlateBlue']
#
# We can define HTML templates by abstracting over HTML.doc using a function.
#
#   def custom_page title, contents
#     HTML.doc(lang: 'en') {
#       head { title { text title } }
#       body { inline contents }
#     }
#   end
#
# Now, the initial document above can be defined using this function:
#
#   custom_page 'Hello', HTML.fragment { h1 { text 'Hello <HTML>' } }
#
# Author:: Sebastian Fischer <mail@sebfisch.de>
# License:: MIT
#
class HTML
  # Creates an HTML document. Optional named parameters are used as attributes
  # on the generated <html> tag. The children of the <html> element are
  # specified in a block given to this method. Text can be inserted using
  # +text+ which automatically replaces special characters with HTML entities.
  # To include a string <em>as is</em> use +inline+ instead.
  #
  # Example:
  #   HTML.doc(lang: "en") {
  #     head { title { text "Hello" } }
  #     body { h1(class: title) { text "Hello <HTML>" } }
  #   }
  #
  def self.doc attrs = {}, &children
    return "<!doctype html>" <<
              HTML.fragment { html(attrs) { instance_eval(&children) } }
  end

  # Creates an HTML fragment. No <tt><html></tt> tags are generated.
  # Unlike a document, a fragment can consist of multiple elements.
  #
  # Example:
  #   HTML.fragment { (1..3).each { |n| li { text n } } }
  #
  def self.fragment &children
    return HTML.new.fragment(&children)
  end

  # The constructor does not need to be called explicitly.
  def initialize
    @entities = HTMLEntities.new
  end

  # This method does not need to be called explicitly.
  def fragment &children
    @doc = ""
    instance_eval(&children)
    return @doc
  end

  private

  def text x
    return inline @entities.encode x.to_s.gsub(/\s+/," "), :named, :decimal
  end

  def inline txt
    @doc << txt
    return txt
  end

  def elem name, attrs = {}, &children
    open_elem name, attrs
    instance_eval(&children)
    @doc << "</#{name}>"
    return nil
  end

  def open_elem name, attrs = {}
    quoted = { '"' => "&quot;", '&' => "&amp;" }
    @doc << "<#{name}" << attrs.collect do |k,v|
      ' '+k.to_s+'="'+v.to_s.chars.collect{|c|quoted[c]||c}.join+'"'
    end.join << ">"
    return nil
  end

  def self.define_elem name
    define_method name do |attrs = {}, &children|
      if children.nil? then
        elem(name, attrs) {}
      else
        elem name, attrs, &children
      end
    end
  end

  def self.define_open_elem name
    define_method name do |attrs = {}|
      open_elem name, attrs
    end
  end

  @@elems =
    [:html,:head,:body,:title,:style,
     :header,:nav,:aside,:main,:section,:article,:footer,:address,
     :h1,:h2,:h3,:h4,:h5,:h6,:p,:pre,:blockquote,:figure,:figcaption,
     :ol,:ul,:dl,:li,:dt,:dd,:div,:a,
     :b,:em,:i,:kbd,:mark,:s,:small,:strong,:sub,:sup,:u,
     :cite,:q,:defn,:abbr,:code,:var,:samp,:time,:ruby,:rt,:rp,:bdi,:bdo,
     :br,:wbr,:del,:ins,:span,:map,
     :table,:caption,:col,:colgroup,:thead,:tbody,:tfoot,:tr,:th,:td,
     :picture,:canvas,:svg,:math,:iframe,:object,:audio,:video,
     :form,:fieldset,:legend,:label,:datalist,
     :button,:select,:optgroup,:option,:textarea,
     :output,:progress,:meter,
     :script,:noscript,:canvas,:content,:decorator,:element,:shadow,:template,
     :details,:summary,:dialog,:menu,:menuitem,:command]

  @@elems.each { |name| self.define_elem name.to_s }

  @@unclosed_elems =
    [:area,:base,:br,:col,:embed,:hr,:img,:input,:link,:meta,:param,
     :source,:track,:wbr]

  @@unclosed_elems.each { |name| self.define_open_elem name.to_s }
end
