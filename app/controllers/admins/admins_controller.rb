module Admins
  class AdminsController < Admins::ApplicationController

    # TODO: Add a before_action :require_admin! or something with a matching private method
    # Otherwise non-admins can see the orders controller


    skip_before_action :require_authentication, only: [:new, :create]
    def new
      @admin = Admin.new
    end

    # TODO: Remove or protect in some way
    # Currently someone could just send a raw HTTP request to this endpoint to make an admin
    # Also, remove the route if it's going to be removed.
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
