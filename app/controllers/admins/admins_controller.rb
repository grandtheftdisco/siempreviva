module Admins
  class AdminsController < Admins::ApplicationController
    skip_before_action :require_authentication, only: [:new, :create]
    def new
      @admin = Admin.new
    end

    def create
      @admin = Admin.new(admin_params)

      if @admin.save
        redirect_to @admin, notice: "Admin account successfully created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @admin = Admin.find(params[:id])
    end

    private
    
    def admin_params
      params.require(:admin)
            .permit(:email_address,
                    :password,
                    :password_confirmation)
    end
  end
end