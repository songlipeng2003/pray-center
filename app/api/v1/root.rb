module V1
  class Root < Grape::API
    default_format :json
    format :json
    # error_formatter :json, V1::ErrorFormatter

    version 'v1', using: :path

    before do
      # error!("401 Unauthorized", 401) unless current_application
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!(e.message, 422)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      error!(e.message, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error!(e.message, 422)
    end

    helpers do
      def logger
        API.logger
      end

      def permitted_params
        @permitted_params ||= declared(params, include_missing: false)
      end

      def clean_params(params)
        ActionController::Parameters.new(params)
      end

      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated? :scope => :user
        access_token = params[:access_token] || request.headers['X-Access-Token'];
        access_token && @user = User.find_by_authentication_token(access_token)
      end

      def authenticate!
        error!("401 Unauthorized", 401) unless authenticated
      end

      def current_user
        # warden.user :scope => :user || @user
        @user
      end

      def current_application
        api_key = params[:api_key] || request.headers['X-Api-Key']
        @application ||= Application.where(token: api_key).first
      end

      def client_ip
        env['action_dispatch.remote_ip'].to_s
      end
    end

    mount V1::Categories
    mount V1::AuthCodes
    mount V1::Accounts
    mount V1::FavoritedUsers
    mount V1::Posts
    mount V1::Regions
    mount V1::Users

    add_swagger_documentation hide_documentation_path: true,
      base_path: '/api',
      api_version: 'v1',
      schemes: ['http']
  end
end
