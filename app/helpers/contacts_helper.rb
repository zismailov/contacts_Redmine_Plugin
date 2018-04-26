module ContactsHelper
  def contact_url(contact)
    project_id = @project.blank? ? contact.project : @project
    { controller: "contacts", action: "show", project_id: project_id, id: contact.id }
  end
end
