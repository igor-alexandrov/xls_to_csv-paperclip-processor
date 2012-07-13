# Ruby on Rails  Paperclip xls to csv Processor #

This gem is Paperclip processor, that uses xls2csv to convert .xls to .csv.

## Requirements ##

* [Paperclip][0] ~> 2.5
* [xls2csv][2]

## Installation ##

    gem 'xls_to_csv-paperclip-processor'
    
## xls2csv Instalation ##

Install [xls2csv][2] using your favorite package manager. On OS X, the easiest way to do it is by using [Homebrew][3].

    sudo brew install catdoc
    
Various linux distributions should use similar methods with their respected package managers.

## Using Processor ##

Use it as you would any other Paperclip processor. In your model:

    class SomeCsvAttachement < ActiveRecord::Base
      has_attached_file :data,
                        :styles => {
                          :converted => {                       
                             :format => "csv",
                             :params => "-c, -q 3"
                          }
                        },
                        :path => ":rails_root/data/some_csv_attachements/:id_partition/:basename.:extension",
                        :processors => [:xls_to_csv]
  
      validates_attachment_content_type :data, :content_type => ['text/csv','text/comma-separated-values','text/csv','application/csv','application/excel','application/vnd.ms-excel','application/vnd.msexcel','text/anytext','text/plain']    
    end
                      
which will convert your .xls document into .csv, and keep both files (.xls and .csv) on the server. If your attachment is not a .xls it will just copy it.


[0]: https://github.com/thoughtbot/paperclip
[1]: http://rubyonrails.org/
[2]: http://search.cpan.org/~ken/xls2csv-1.06/script/xls2csv
[3]: http://mxcl.github.com/homebrew/