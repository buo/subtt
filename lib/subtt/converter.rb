module Subtt
  def self.smi2srt(smi_path)
    srt_path = smi_path.gsub(/\.smi/, '.srt')
    puts "converted into #{srt_path}"
    File.open(srt_path, 'w') do |srt|
      smi = SAMI.load smi_path

      duration = 5000
      smi.each_with_index do |e, i|
        from = Duration.new(e[0])
        to = Duration.new(e[0] + duration)

        nextSync = smi.fetch(i+1)
        if !nextSync.nil? and nextSync[0] <= to
          to.set nextSync[0] - 10
        end

        srt.write "#{i}\n#{from} --> #{to}\n#{e[1]}\n\n"
      end
    end
  end
end
