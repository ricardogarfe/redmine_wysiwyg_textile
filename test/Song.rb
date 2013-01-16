class Song

    attr_reader :name, :artist, :duration
    attr_writer :duration
    @@plays=0
    def initialize(name,artist,duration)
        @name=name
        @artist=artist
        @duration=duration
        @plays=0
    end
end