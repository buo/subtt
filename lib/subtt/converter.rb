module Subtt
  def self.ms2ts(ms)
    hours = (ms / 3600000).to_i
    ms -= hours * 3600000

    minutes = (ms / 60000).to_i
    ms -= minutes * 60000

    seconds = (ms / 1000).to_i
    ms -= seconds * 1000

    "%02d:%02d:%02d,%03d" % [hours, minutes, seconds, ms]
  end

  def self.smi2srt(smi_path)
    srt_path = smi_path.gsub(/\.smi/, '.srt')
    puts "converted into #{srt_path}"
    File.open(srt_path, 'w') do |srt|
      smi = SAMI.load smi_path

      duration = 5000
      smi.each_with_index do |e, i|
        from = e[0]
        to = e[0] + duration

        nextSync = smi.fetch(i+1)
        if !nextSync.nil? and nextSync[0] <= to
          to = nextSync[0] - 10
        end

        srt.write "#{i}\n#{ms2ts(from)} --> #{ms2ts(to)}\n#{e[1]}\n\n"
      end
    end
  end
end
