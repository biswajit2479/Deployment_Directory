class UserMailer < ApplicationMailer
	default from: 'notifications@jifflenow.com'

	def access_request
	    @url  = 'http://localhost:3000'
	    mail(to: get_admin_emails, subject: 'Request Application Access')
  	end

  	def get_admin_emails
  		User.admin_users.pluck(:email).join(',')
  	end

end
