module ApplicationHelper

  def groove_session
    client = Groveshark::Client.new(session: session[:groove_session])
    return client
  end
  

end
