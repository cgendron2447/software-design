# Set up for the application and database. DO NOT CHANGE. ###################
require "sinatra"                                                           #
require "sinatra/reloader" if development?                                  #
require "sequel"                                                            #
require "logger"                                                            #
require "twilio-ruby"                                                       #
DB ||= Sequel.connect "sqlite://#{Dir.pwd}/development.sqlite3"             #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                #
def view(template); erb template.to_sym; end                                #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret' #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }   #
after { puts }                                                              #
#############################################################################

events_table = DB.from(:events) #just two variables we can use if we want
rsvps_table = DB.from(:rsvps) #from these we can use the sequel things



#write the 'root' route
get "/" do
    #"Hello!" #do a small test to prove it works before you move on!!!!
    puts events_table.all #did a SELECT * from events (table) - returned an array of hashes 
    @events = events_table.all
    view "events"    
end

get "/events/:id" do
    @event_detail = events_table.where(id: params[:id]).first #.first give us the result in an array of hashes!!
    view "event_info"
end

get "/events/:id/rsvps/new" do
     @event_detail = events_table.where(id: params[:id]).first   
     view "new_rsvp"
end