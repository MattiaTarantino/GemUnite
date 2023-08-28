class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  require 'rest-client'
  CLIENT_ID = ENV.fetch("github_client_ID")
  CLIENT_SECRET = ENV.fetch("github_secret")
  def parse_response(response)
    case response
    when Net::HTTPOK
      JSON.parse(response.body)
    else
      puts response
      puts response.body
      {}
    end
  end

  def exchange_code(code)
    params = {
      "client_id" => CLIENT_ID,
      "client_secret" => CLIENT_SECRET,
      "code" => code
    }
    result = Net::HTTP.post(
      URI("https://github.com/login/oauth/access_token"),
      URI.encode_www_form(params),
      {"Accept" => "application/json"}
    )

    parse_response(result)
  end

  def user_info(token)
    uri = URI("https://api.github.com/user")

    result = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      body = {"access_token" => token}.to_json

      auth = "Bearer #{token}"
      headers = {"Accept" => "application/json", "Content-Type" => "application/json", "Authorization" => auth}

      http.send_request("GET", uri.path, body, headers)
    end

    parse_response(result)
  end

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    code = params["code"]

    token_data = exchange_code(code)

    Rails.logger.debug("CODE: #{code.inspect}")
    Rails.logger.debug("TOKEN DATA: #{token_data.inspect}")

    if token_data.key?("access_token")
      token = token_data["access_token"]

      user_info = user_info(token)
      handle = user_info["login"]
      name = user_info["name"]

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
      else
        session["devise.github_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      render = "Authorized, but unable to exchange code #{code} for token. #{token_data["error"]}}"
      redirect_to root_path, notice: render
    end
  end

  def failure
    set_flash_message! :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to root_path, notice: "Unable to authenticate with Github. #{params}"
  end
end
