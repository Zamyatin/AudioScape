module ApplicationHelper

  def groove_session
    Grooveshark::Client.new(session: session[:groove_session])
  end
  
  def from_whence_i_came
    ref_path = URI(request.referer).path
    return ref_path
  end
  
  def grooveshark_url(link)
    groove_session.get_song_url_by_id(link) #whichever
  end
  
end
