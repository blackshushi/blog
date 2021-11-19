class ApplicationController < ActionController::Base
	rescue_from AbstractController::ActionNotFound, with: :not_found

	def not_found
		render text: 'Action not found'
	end
end
