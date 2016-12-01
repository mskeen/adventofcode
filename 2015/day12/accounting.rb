require 'json'

def sum(doc, total = 0)
  case doc
  when Fixnum then total += doc
  when Hash
    doc.keys.each { |k| total = sum(doc[k], total) } unless doc.values.include? "red"
  when Array
    doc.each { |element| total = sum(element, total) }
  end
  total
end

begin
  puts sum(JSON.parse(File.read('./input.json')))
end
