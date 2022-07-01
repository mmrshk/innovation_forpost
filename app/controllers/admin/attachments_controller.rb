class Admin::AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.all
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      redirect_to admin_attachments_path
    else
      render :new
    end
  end

  def update
    @attachment = Dog.find(params[:id])
    @attachment.update(attachment_params)

    redirect_to new_admin_attachment_path
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    redirect_to new_admin_attachment_path
  end

  def attachment_params
    params.require(:attachment).permit(:name, :media_file)
  end

end
