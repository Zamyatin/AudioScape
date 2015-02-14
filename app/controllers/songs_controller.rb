class SongsController < ApplicationController

  def index

  end

  def new

  end

  def show
    client = Grooveshark::Client.new({session: session[:groove_session]})
    @groove_song = Song.find(params[:id])
    @groove_url = client.get_song_url_by_id(@groove_song.link)
  end

  def create
    song = Song.create(title: params[:song_name], artist: params[:song_artist], link: params[:song_id], playlist_id: params[:playlist_id])
    redirect_to "/playlists/#{params[:playlist_id]}/songs/new"

  end

  def destroy

  end

  def update

  end

  def search
    @songs = []

    client = Grooveshark::Client.new({session: session[:groove_session]})
    tracks = client.search_songs(params[:songs][:title])

      tracks.each do |track|
        @songs << track if track.artist.downcase == params[:songs][:artist] || track if track.artist.downcase == 'various artists'
      end

  end

end
