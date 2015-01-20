class RegistrationsController < Devise::RegistrationsController
  # Overwrite update_resource to let users to update their user without giving their password
  def update_resource(resource, params)
    params.delete("current_password")
    resource.update_without_password(params)
  end
end
