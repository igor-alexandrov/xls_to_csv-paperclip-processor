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
      Paperclip.run(self.command, self.parameters(src, dst))      
    rescue StandardError => e
      raise "There was an error converting #{@basename} to csv: #{e.message}"
    end

    return dst
  end

protected

  def command
    case @current_format
    when '.xls'
      'xls2csv'
    when '.xlsx'
      'xlsx2csv'  
    else
      'cp'
    end    
  end

  def parameters(src, dst)
    p = []

    if self.command == 'xls2csv'
      p << [@params, "#{File.expand_path(src.path)}", "> #{File.expand_path(dst.path)}"]
    else
      p << ["#{File.expand_path(src.path)}", "#{File.expand_path(dst.path)}"]  
    end
    
    p.flatten.compact.join(" ").strip.squeeze(" ")
  end

end