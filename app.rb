#! /usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'open-uri'
require 'json'

get '/' do
  haml :index
end

post '/' do
  @result = JSON.parse(open("https://maps.googleapis.com/maps/api/place/search/json?location=13.055399,80.257874&radius=#{params[:rad]}&types=#{params[:types]}&sensor=false&key=AIzaSyA3wwb_zfHVHl-RNclVWWis3aomjCWq5D0"))
 
  haml :index
end

#checkin not added yet
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
%h3 Index
%form(action='/' method='POST')
  radius
  %input(type="text" name="rad" value=@rad)
  types
  %input(type="text" name="types" value=@types)
  %input(type="submit")
%div
  -@result.each do |result|
    %pre= result['results']['name']
    %img#thumb{:src => "#{result['results']['icon']}"}
 
