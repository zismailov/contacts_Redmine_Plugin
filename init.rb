Redmine::Plugin.register :contacts do
  name "Contacts plugin test"
  author "Zulkar"
  description "This is a plugin for Redmine"
  version "0.0.1"
  url "http://example.com/path/to/plugin"
  author_url "http://example.com/about"

  project_module :contacts do
    permission :view_contacts, contacts: %i[index show]
    permission :create_contact, contacts: %i[index show new create]
    permission :edit_contact, contacts: %i[index show edit new create update]
    permission :delete_contacts, contacts: %i[index show destroy]
  end

  menu :project_menu, :contacts, :project_contacts_path, caption: "Contacts", after: :news
end

Redmine::Search.available_search_types << "contacts"
Redmine::Activity.register :contacts
CustomFieldsHelper::CUSTOM_FIELDS_TABS << { name: "ContactCustomField", partial: "custom_fields/index",
                                            label: :label_contact_plural }
