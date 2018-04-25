class ContactsController < ApplicationController
  helper :custom_fields
  helper :attachments
  include AttachmentsHelper

  before_action :find_contact, only: %i[edit update destroy show]
  before_action :find_optional_project

  def index
    @contacts = Contact.all.where(project_id: @project.id)
  end

  def new
    @contact = Contact.new
    @contact.safe_attributes = params[:contact]
  end

  def create
    @contact = Contact.new
    @contact.safe_attributes = params[:contact]
    @contact.save_attachments(params[:attachments])
    if @contact.save
      render_attachment_warning_if_needed(@contact)
      flash[:notice] = l(:notice_successful_create)
      redirect_to project_contacts_path(@project)
    else
      render action: "new"
    end
  end

  def show; end

  def edit; end

  def update
    @contact.safe_attributes = params[:contact]
    @contact.save_attachments(params[:attachments])
    if @contact.update_attributes(params[:contact])
      render_attachment_warning_if_needed(@contact)
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_contacts_path(@project)
    else
      render action: "edit", project_id: @contact.project_id
    end
  end

  def destroy
    if @contact.destroy
      flash[:notice] = l(:notice_successful_delete)
      redirect_to project_contacts_path(@project)
    else
      flash[:error] = l(:notice_unsuccessful_save)
    end
  end

  private

  def find_contact
    binding.pry
    @contact = Contact.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
