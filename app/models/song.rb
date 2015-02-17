class Song < ActiveRecord::Base
  belongs_to :playlist

  include GrooveSharkSong
end
