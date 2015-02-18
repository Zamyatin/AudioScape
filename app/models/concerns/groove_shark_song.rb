module GrooveSharkSong
  extend ActiveSupport::Concern
  
  attr_writer :grooveshark_client
  attr_writer :grooveshark_song  

  STOCK_IMG = '/images/devil_horns.jpg'
  
  STOCK_IMG = '/images/devil_horns.jpg'
  
  module InstanceMethods

    def grooveshark_client
      @grooveshark_client ||= Grooveshark::Client.new
    end
  
    def grooveshark_song(link)
      @groovershark_song ||= grooveshark_client.get_song_by_id(link) # wrong method
    end
      
    def grooveshark_url(link)
      grooveshark_client.get_song_url_by_id(link) #whichever
    end
  end
  
  module ClassMethods
    def new_from_grooveshark(client, gs_song)
      s = Song.new(grooveshark_client: client, grooveshark_song: gs_song)
      s.title = gs_song.name
      s.artist = gs_song.artist
      s.link = gs_song.id
      s.source = "grooveshark"
      s.coverart = gs_song.artwork == '' ? STOCK_IMG : "http://images.gs-cdn.net/static/albums/#{gs_song.artwork}"
      return s
    end
  end
end
