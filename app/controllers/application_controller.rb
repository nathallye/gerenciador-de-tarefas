class ApplicationController < ActionController::Base
  before_action :authenticate # para autenticação ocorrer em todos os controllers(todas as páginas)

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password| # método de autenticação mais simples que o rails disponibiliza
      username == Rails.application.credentials.authentication[:username] && 
      password == Rails.application.credentials.authentication[:password] # esses dados estão criptografados no servido no arquivo temporário credentials (não vai para o repositório público) saber mais emm https://guides.rubyonrails.org/security.html
    end
  end
  
end
