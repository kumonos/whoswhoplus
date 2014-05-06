class SystemMailer < ActionMailer::Base
  default from: 'whoswhoplus-support@kumonos.jp'

  def internal_server_error(request, exception, inquiry_key)
    @request = request
    @exception = exception
    @inquiry_key = inquiry_key
    mail to: 'whoswhoplus-error@kumonos.jp', subject: "[#{Rails.env.upcase}] #{exception.message}"
  end
end
