class ApplicationController < ActionController::Base
  before_action :basic_auth
  # 実行指示（スイッチ）
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  # deviseのパラメーターを許可する設定
  def configure_permitted_parameters
    # 新規登録（sign_up）の際に、ER図で定義した各カラムの保存を許可します
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date])
  end
end
