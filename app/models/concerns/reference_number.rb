module ReferenceNumber
	extend ActiveSupport::Concern

	def generate_reference_number
		loop do 
			random_length = reference_number_length - reference_number_prefix.length
			random = SecureRandom.hex(random_length/2)

			reference_number = reference_number_prefix + random

			if self.class.where(reference_number: reference_number).size == 0
				break reference_number
			end
		end
	end

	private
	def reference_number_length
		16
	end

	def reference_number_prefix
		''
	end
end