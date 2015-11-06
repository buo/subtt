require 'iconv'

module Subtt
  class SAMI
    include Enumerable

    def self.load(file)
      smi = SAMI.new
      smi.parse(File.binread(file))
      smi
    end

    def parse(txt)
      @txt = txt
      @sync = []

      # TODO detect encoding
      txt = Iconv.iconv('UTF-8', 'CP949', txt).join
      txt.scan(/<SYNC Start=(\d+)><P Class=.+>((?:.|[\r\n])*?)(?:<SYNC|<\/BODY)/) do |m|
        t, s = m[0].to_i, m[1]

        # <br> tag
        s = s.gsub(/<br( \/)?>/, "\n")

        # squash multiple newline
        s = s.gsub(/\r\n/, "\n")
        s = s.gsub(/[\n]{2,}/, "\n")

        # strip HTML tags
        s = s.gsub(/<.*?>/, '')

        # strip HTML entities
        s = s.gsub(/&[a-z]+;/, ' ')

        s = s.strip

        @sync << [t, s]
      end
    end

    def each
      @sync.each do |t, s|
        yield t, s
      end
    end

    def fetch(n)
      @sync[n] if n < @sync.length
    end

    def to_s
      @sync.each do |t, s|
        puts "[#{t}]", s, "\r\n"
      end
    end
  end
end
