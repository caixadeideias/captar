module ProjectsHelper
  def project_title
    (@project.nil? || @project.title.nil?) ? 'Captar' : @project.title
  end
end
