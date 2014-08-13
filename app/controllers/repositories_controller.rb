class RepositoriesController < ApplicationController

  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def new
    @repository = Repository.new
  end

  def edit
    @repository = Repository.find(params[:id])
  end

  # POST /repositories
  def create
    organizer = SetupRepository.perform(repository_params)

    if organizer.success?
      redirect_to organizer.repository, notice: 'Repository was successfully created.'
    else
      render :new, notice: 'Repository could not be created'
    end

  end

  # PATCH/PUT /repositories/1
  def update
    @repository = Repository.find(params[:id])

    # model does not have the :url attribute
    expected_params = repository_params.keep_if {|key, _| key != :url}

    if @repository.update(expected_params)
      redirect_to @repository, notice: 'Repository was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /repositories/1
  def destroy
    @repository = Repository.find(params[:id])

    @repository.destroy
    redirect_to repositories_url, notice: 'Repository was successfully destroyed.'
  end

  private

  def repository_params
    {
      name: params[:repository][:name],
      organization: params[:repository][:organization],
      url: "#{request.protocol}#{request.host_with_port}"
    }
  end
end
