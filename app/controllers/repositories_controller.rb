class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]

  # GET /repositories
  def index
    @repositories = Repository.all
  end

  # GET /repositories/1
  def show
  end

  # GET /repositories/new
  def new
    @repository = Repository.new
  end

  # GET /repositories/1/edit
  def edit
  end

  # POST /repositories
  def create
    @repository = Repository.new(repository_params)

    if @repository.save
      result = RegisterGitHubWebhook.perform(webhook_params(@repository)).success?
      if result
        redirect_to @repository, notice: 'Repository was successfully created.'
      else
        redirect_to @repository, notice: 'Webhook could not be created.'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /repositories/1
  def update
    if @repository.update(repository_params)
      redirect_to @repository, notice: 'Repository was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /repositories/1
  def destroy
    @repository.destroy
    redirect_to repositories_url, notice: 'Repository was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Repository.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def repository_params
      params.require(:repository).permit(:name, :organization)
    end

    def webhook_params(repository)
      {repo_id: repository.id, url: "#{request.protocol}#{request.host_with_port}"}
    end
end
