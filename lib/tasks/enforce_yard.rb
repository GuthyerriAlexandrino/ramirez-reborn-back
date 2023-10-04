# frozen_string_literal: true

require 'open3'

# Module to force yard in pipeline
module EnforceYard
  def self.enforce_yard(percentage)
    exec_opt = RUBY_PLATFORM =~ /x64-mingw-ucrt/ ? 'bundle exec rake yard' : 'bin/bundle exec rake yard'
    Open3::popen3(exec_opt) do | stdin, stdout, stderr |
      output = stdout.readlines
      line = output[6]
      if line[1..2].to_i == percentage
        print "Ok.#{line}"
        exit(true)
      end
      print output.join
      exit(false)
    end
  end
end

EnforceYard.enforce_yard(100)
