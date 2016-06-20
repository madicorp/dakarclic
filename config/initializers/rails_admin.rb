RailsAdmin.config do |config|

  ### Popular gems integration
    # config.main_app_name = Proc.new { |controller| [  "DakarClic - #{controller.params[:action].try(:titleize)}" ] }

  # == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :admin
  # end
  # config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan, AdminAbility
    config.authorize_with do
        redirect_to main_app.new_user_session_path unless current_user
    end
  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end