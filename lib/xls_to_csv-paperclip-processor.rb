require 'paperclip'
class Paperclip::XlsToCsv < Paperclip::Processor
  attr_accessor :file, :params, :format

  def initialize(file, options = {}, attachment = nil)
    super

    @file           = file
    @params         = options[:params]
    @current_format = File.extname(@file.path)
    @basename       = File.basename(@file.path, @current_format)
    @format         = options[:format]
  end

  def make
    src = @file
    dst = Tempfile.new([@basename, @format ? "#{@format}" : 'csv'].compact.join("."))

    begin      
      Paperclip.run(self.command, self.parameters, :source => File.expand_path(src.path),:dest => File.expand_path(dst.path))      
    rescue StandardError => e
      raise Paperclip::StandardError, "There was an error converting #{@basename} to csv: #{e.message}"
    end

    return dst
  end

protected

  def command
    @current_format == '.xls' ? 'xls2csv' : 'cp'
  end

  def parameters
    p = []

    if self.command == 'xls2csv'
      p << [@params, ":source", "> :dest"]
    else
      p << [":source", ":dest"]  
    end
    
    p.flatten.compact.join(" ").strip.squeeze(" ")
  end

end