module ApplicationHelper
  def login_link
    login_url = case Rails.env
                when 'development'
                  "/auth/google_oauth2"
                else
                  "/auth/google_oauth2"
                end
    link_to "Sign in with Google", login_url, id: "sign_in", class: 'btn btn-primary'
  end
end
