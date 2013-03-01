module ProjectsHelper
  def project_title
    (@project.nil? || @project.title.nil?) ? 'Captar' : @project.title
  end

  def project_link
    params[:project_id].nil? ? root_url : project_url(params[:project_id])
  end
end
