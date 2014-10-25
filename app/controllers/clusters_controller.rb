class ClustersController < ApplicationController
  respond_to :html, :xml, :json

  def import
    file = import_params
    
    @cluster = Cluster.new
    @cluster.status = Cluster::STATUS_PENDING
    @cluster.save!
    
    run(@cluster, file)
    
    redirect_to cluster_url(@cluster)
  end

  def show
    @cluster = Cluster.find(params[:id])

    respond_with(@cluster) do |format|
      format.js { render :partial => 'status.html.erb' }
    end
  end

private

  def run(cluster, file)
    runner = RunnerClustering.new
    runner.execute(cluster, file.content_type, file.read)
  end

  def import_params
    params.require(:filename)
  end

end