#! /usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'open-uri'
require 'json'

get '/' do
  haml :index
end

#summa
get '/summa/' do
  haml :summa 
end

post '/summa' do
  @result = JSON.parse(open("https://maps.googleapis.com/maps/api/place/search/json?location=13.055399,80.257874&radius=#{params[:rad]}&types=#{params[:types]}&sensor=false&key=AIzaSyA3wwb_zfHVHl-RNclVWWis3aomjCWq5D0").read).to_hash
  #@result = JSON.pretty_generate(data).to_json
  #placeref = @result['results'][1]['reference']
  for i in 1..8 do
  puts @result['results'][i]['name']  
  end  
 
  haml :summa
end

#checkin
post '/checkin' do
 

  haml :checkin
end

__END__
@@ layout
%html
  %head
    %title Testing Google Places API
  %body
    #header
      %h1 Testing Google Places API
    #content
      =yield
  %footer
    %a(href="/")Back to index

@@ index
%p
  This is the homepage of the test app
  Google Places API is used
  %a(href="/summa")Click  here  

@@ summa
%h3 Summa
%form(action='/summa' method='POST')
  radius
  %input(type="text" name="rad" value=@rad)
  types
  %input(type="text" name="types" value=@types)
  %input(type="submit")
  %pre=  "#{@result['results'][1]['name']}"
  %img#thumb{:src => "#{@result['results'][1]['icon']}" }
 
