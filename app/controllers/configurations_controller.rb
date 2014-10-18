class ConfigurationsController < ApplicationController
  def edit
    @configuration = ::Configuration.first
  end

  def update
    @configuration = ::Configuration.first
    @configuration.update(configuration_params)

    flash[:notice] = "Configuration successfully updated"
    redirect_to edit_configuration_path
  end

  private

  def configuration_params
    params.require(:configuration).permit(:global_support, :cluster_support, :number_cluster)
  end

end
