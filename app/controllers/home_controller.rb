require 'zlib'
require 'archive/tar/minitar'
require 'securerandom'

class HomeController < ApplicationController
  def index
  end
  
  def import
    file = import_params

    dest_dir_name = SecureRandom.hex
    dest_dir = Rails.root.join("public/data/", dest_dir_name)

    case file.content_type
      when "application/octet-stream", "application/x-tar"    

        begin        
          tgz = Zlib::GzipReader.new(file)
          Archive::Tar::Minitar::unpack(tgz, dest_dir.to_s)
        rescue NoMethodError
        end

      #when "application/zip"
    end
    
    HierarchicalClustering.fihc( )
    
  end
  
  private

  def import_params
    params.require(:filename)
  end
end
