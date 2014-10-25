require 'zip'
require 'zlib'
require 'archive/tar/minitar'
require 'securerandom'
require 'hierarchical_clustering'
require 'vina_output_manager'

class RunnerClustering

    def execute(cluster, content_type, content)
        dest_dir = unpack(content_type, content)        
        run(cluster, dest_dir)
    end
    
    handle_asynchronously :execute

private
    
    def unpack(content_type, content)
        dest_dir_name = SecureRandom.hex
        dest_dir = Dir.mktmpdir

        case content_type
          when "application/octet-stream", "application/x-tar"
            begin
              tgz = Zlib::GzipReader.new(content)
              Archive::Tar::Minitar::unpack(tgz, dest_dir.to_s)
            rescue NoMethodError
            end

          when "application/zip"      
            tempfile = Tempfile.new('hvina', :encoding => 'utf-8')
            tempfile.write(content.force_encoding("utf-8"))
            tempfile.close

            Zip::File.open(tempfile.path) do |zip_file|
              zip_file.each do |f|
                f_path = File.join(dest_dir.to_s, f.name)
                FileUtils.mkdir_p(File.dirname(f_path))
                zip_file.extract(f, f_path) unless File.exist?(f_path)
              end
            end

        end
        
        dest_dir.to_s 
    end
    
    def run(cluster, dirname)
        global_support, cluster_support, number_cluster = get_configurations

        result_dir = Rails.root.join("public/data")
        result_path = "#{result_dir}/#{SecureRandom.hex}"
                
        algorithm = Clustering::Fihc::Controller.new(global_support, cluster_support, number_cluster)
        algorithm.output_manager(HVinaOutputManager.new(result_path))

        HierarchicalClustering.new(dirname, algorithm)
        
        cluster.update(status: Cluster::STATUS_OK)
    end
    
    def get_configurations
        @configuration = ::Configuration.first        
        [@configuration.global_support, @configuration.cluster_support, @configuration.number_cluster]
    end
end