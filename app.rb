#!/usr/bin/env ruby
require "sinatra/activerecord"
require "sinatra"
require "sqlite3"
require "rake"

set :database, "sqlite3:///simplegraph.sqlite3"

class Graph < ActiveRecord::Base
end

helpers do
  # If @title is assigned, add it to the page's title.
  def title
    if @title
      "#{@title} -- My Blog"
    else
      "My Blog"
    end
  end
end 

get '/' do
  @graph = Graph.new
  @data = Graph.all
  erb :"index"
  # insert a new value
  # show me the graph
end

post '/newvalue' do
  @graph = Graph.new(params[:graph])
  if @graph.save
    redirect "/"
  else
    erb :"index"
  end
end

get '/insertvalue' do
  params = request.env['rack.request.query_hash']
  Graph.create(value: params['value'], date: params['date'])
  "<html><body>
  value is: #{params['value']}<br>
  date is: #{params['date']}<br>
  </body></html>"
end

get '/graphit' do
  @js = ['jquery.min.js','highcharts/js/highcharts.js']
  @data=Graph.all
  erb :"graphit"
end
