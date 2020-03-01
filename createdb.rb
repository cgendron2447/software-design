# Set up for the application and database. DO NOT CHANGE. ##############
require "sequel"                                                       #
DB = Sequel.connect "sqlite://#{Dir.pwd}/development.sqlite3"          #
########################################################################  

# Database schema - this should reflect your domain model - this goes out and creates our two tables
DB.create_table! :events do
  primary_key :id #tell it what's the primary key
  String :title
  String :description, text: true #makes size of the field bigger
  String :date
  String :location
end
DB.create_table! :rsvps do
  primary_key :id #fixed increments
  foreign_key :event_id #how the tables are hooked together
  Boolean :going
  String :name
  String :email
  String :comments, text: true
end

# Insert initial (seed) data - this inserts our seed data (so we can see how it works)
events_table = DB.from(:events) #create the 'events table'

events_table.insert(title: "Bacon Burger Taco Fest", 
                    description: "Here we go again bacon burger taco fans, another Bacon Burger Taco Fest is here!",
                    date: "June 21",
                    location: "Kellogg Global Hub")

events_table.insert(title: "Kaleapolooza", 
                    description: "If you're into nutrition and vitamins and stuff, this is the event for you.",
                    date: "July 4",
                    location: "Nowhere")

                    #if you ruby it again, it re-writes the dev.sqlite3 thing, but if you made inserts from your app, it would write over them
                    #so, use the program sparingly...
                    