class MainController < ApplicationController

	def creatediagram
		require 'uri'
		@id = params[:id]
		@value = params[:value]

		@url = "https://wikiflow.firebaseio.com/#{@id}"

		Firebase.base_uri = URI.escape(@url)
		response = Firebase.push('current', @value)

		if (response)
			render :text => 'Diagram successfully created'
		else
			render :text => 'Failed :( Try again.'
		end

	end

	def createsubdiagram
		require 'uri'
		@id = params[:id]
		@value = params[:value]

		@url = "https://wikiflow.firebaseio.com/#{@id}"

		Firebase.base_uri = URI.escape(@url)
		response = Firebase.push('subdiagrams', @value)

		if (response)
			render :text => 'Subdiagram successfully created'
		else
			render :text => 'Failed :( Try again.'
		end

	end


	def showdiagram
		require 'json'
		require 'uri'
		@id = params[:id]

		@url = "https://wikiflow.firebaseio.com/#{@id}"

		Firebase.base_uri = URI.escape(@url)
		@query = Firebase.get('current').body

		respond_to do |format|
		  format.html { render json: @query }
	      format.json { render json: @query }
	      format.xml { render xml: @query }
	    end
	end

	def updatediagram
		@id = params[:id]
		@value = params[:value]

		Firebase.base_uri = "https://wikiflow.firebaseio.com/#{@id}/current"
		response = Firebase.set('height', 'heightchanged2')
		response = Firebase.set('text', 'textchanged2')

		if (response)
			render :text => 'Successful update'
		else
			render :text => 'Update failed :( Try again.'
		end
	end

	def showsubdiagram
		require 'uri'
		@id = params[:id]

		@url = "https://wikiflow.firebaseio.com/#{@id}"

		Firebase.base_uri = URI.escape(@url)
		@query = Firebase.get('subdiagrams').body

		respond_to do |format|
		  format.html { render json: @query }
	      format.json { render json: @query }
	      format.xml { render xml: @query }
	    end
	end

	def deletediagram
		require 'uri'
		@id = params[:id]

		@url = "https://wikiflow.firebaseio.com/"
		Firebase.base_uri = URI.escape(@url)
		response = Firebase.delete("#{@id}")

		if (response)
			render :text => 'Successfully deleted diagram'
		else
			render :text => 'Delete failed :( Try again.'
		end
	

	end

	def deletesubdiagram
		require 'uri'
		@id = params[:id]
		@subid = params[:subdiagramid]

		@url = "https://wikiflow.firebaseio.com/#{@id}/subdiagrams"
		Firebase.base_uri = URI.escape(@url)
		response = Firebase.delete("#{@subid}")

		if (response)
			render :text => 'Successfully deleted subdiagram'
		else
			render :text => 'Delete failed :( Try again.'
		end

	end

end
