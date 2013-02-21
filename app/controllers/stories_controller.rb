class StoriesController < ApplicationController
  helper_method :parent, :resource

  # GET /stories
  def index
    @project          = Project.find(params[:project_id])
    @despised_stories = @project.stories_despised
    @wanted_stories   = @project.stories_wanted
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: resource }
    end
  end

  # GET /stories/new
  # GET /stories/new.json
  def new
    @story = parent.stories.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @story }
    end
  end

  # GET /stories/1/edit
  def edit
    resource
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = parent.stories.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to [parent, @story], notice: 'Story was successfully created.' }
        format.json { render json: @story, status: :created, location: @story }
      else
        format.html { render action: "new" }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.json
  def update
    resource

    respond_to do |format|
      if resource.update_attributes(params[:story])
        format.html { redirect_to [parent, resource], notice: 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    resource.destroy

    respond_to do |format|
      format.html { redirect_to parent }
      format.json { head :no_content }
    end
  end

  def want
    story = parent.stories.find(params[:id])
    story.want!
    redirect_to parent
  end

  def despise
    story = parent.stories.find(params[:id])
    story.despise!
    redirect_to parent
  end

  private

  def parent
    @project ||= Project.find(params[:project_id])
  end

  def resource
    @story ||= parent.stories.find(params[:id])
  end
end
