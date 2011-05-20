require 'paperclip'
module Paperclip
  class XlsToCsv < Processor    
    attr_accessor :file, :params, :format

    def initialize file, options = {}, attachment = nil
      super
      @file           = file
      @params         = options[:params]
      @current_format = File.extname(@file.path)
      @basename       = File.basename(@file.path, @current_format)
      @format         = options[:format]
    end

    def make
      src = @file
      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      begin
        parameters = []
        parameters << @params
        parameters << ":source"
        parameters << "> :dest"

        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")
      
      
        system("touch #{dst.path}")
        success = Paperclip.run("xls2csv", parameters, :source => File.expand_path(src.path),:dest => File.expand_path(dst.path))
      rescue PaperclipCommandLineError => e
        raise PaperclipError, "There was an error converting #{@basename} to csv: #{e.message}"
      end
      return dst
    end
  end
end