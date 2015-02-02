require 'open-uri'
require 'json'

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
		url = "http://www.yournavigation.org/api/1.0/gosmore.php?format=geojson" \
		+ "&flat=" + "-" + flat + "." + flatdec + "&flon=" + flon + "." + flondec \
		+ "&tlat=" + "-" + tlat + "." + tlatdec + "&tlon=" + tlon + "." + tlondec \
		+ "&v=motorcar&fast=1&layer=mapnik"
		content = open(url).read
		coordinates = JSON.parse(content)['coordinates']
		type = JSON.parse(content)['type']

		"-------------"
		puts flat
		puts flatdec
		puts url
		puts coordinates.to_s
		"-------------"

		geojson = "{\"type\":\"FeatureCollection\",
		\"crs\":{\"type\":\"name\",\"properties\":{\"name\":\"urn:ogc:def:crs:OGC:1.3:CRS84\"}},
		\"features\":[{\"type\":\"Feature\",\"properties\":{},
		\"geometry\":{\"type\":\"LineString\",\"coordinates\":" + coordinates.to_s + "}}]}"

		test = open("https://raw.githubusercontent.com/tengr/HelloOSM/master/convert.json").read

		render text: geojson

	end

	def parse
		params_string = params[:qs].to_s
		url = "http://www.yournavigation.org/api/1.0/gosmore.php?format=geojson&" + params_string + "&v=motorcar&fast=1&layer=mapnik"

		content = open(url).read
		coordinates = JSON.parse(content)['coordinates']
		type = JSON.parse(content)['type']


		geojson = "{\"type\":\"FeatureCollection\",
		\"crs\":{\"type\":\"name\",\"properties\":{\"name\":\"urn:ogc:def:crs:OGC:1.3:CRS84\"}},
		\"features\":[{\"type\":\"Feature\",\"properties\":{},
		\"geometry\":{\"type\":\"LineString\",\"coordinates\":" + coordinates.to_s + "}}]}"

		puts "+++++++++++++++++++++++"
		puts url
		puts "++++++++++++++++++++++"

		render text: content
	end

	def test
		render text: params[:params].to_s
	end

end
