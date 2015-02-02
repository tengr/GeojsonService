require 'open-uri'

class ConvertController < ApplicationController
	def index
		render text: 'no parameters found!'
	end

	def trans
		flat = params[:flat].to_s
		flatdec = params[:flatdec].to_s
		flon = params[:flon].to_s
		flondec = params[:flondec].to_s
		tlat = params[:tlat].to_s
		tlatdec = params[:tlatdec].to_s
		tlon = params[:tlon].to_s
		tlondec = params[:tlondec].to_s
		url = "http://www.yournavigation.org/api/1.0/gosmore.php?format=geojson" + "&flat=" + flat + "." + flatdec + "&flon=#{flon}" + ".#{flondec}" + "&tlat=#{tlat}" + ".#{tlatdec}" + "&tlon=#{tlat}" + ".#{tlondec}" + "&v=motorcar&fast=1&layer=mapnik"
		content = open(url).read
		render text: content
	end
end
