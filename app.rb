#! /usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'uri'
require 'json'
require 'net/https'

get '/' do
  haml :index
end

post '/' do
   uri=URI.parse(URI.encode("https://maps.googleapis.com/maps/api/place/search/json?location=13.055399,80.257874&radius=#{params[:rad]}&types=#{params[:types]}&sensor=false&key=AIzaSyA3wwb_zfHVHl-RNclVWWis3aomjCWq5D0"))
  http=Net::HTTP.new(uri.host,uri.port) 
  http.use_ssl = true
  http.verify_mode= OpenSSL::SSL::VERIFY_NONE
  request=Net::HTTP::Get.new(uri.request_uri)
  response=http.request(request) 
  json_response= response.body
  @result=JSON.parse(json_response)
 
 
  haml :place
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

  
@@ place
%div
  - @result['results'].each do |res|
    %pre= res['name']
    %img#thumb{:src => "#{res['icon']}"}
 
