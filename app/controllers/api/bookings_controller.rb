
module Api

	class BookingsController < ApplicationController
		
		resource_description do 
			short 'Booking Reference Generation App'
		end

		api :GET, "/bookings", "List Booking references"
		def index
			@bookings = Booking.all 
		end		

		api :POST, '/bookings/generate_reference', "Generate booking reference"
		
		param :booking, Hash, desc: "Booking Reference info", required: true do
			param :id, Fixnum, desc: "Booking Reference ID", required: true
			param :reference_num, String, desc: "Generated Booking Reference", required: true
		end
		def generate_reference
			flag = 0
			while flag==0
				temp = []
				3.times do
					temp.push(('A'..'Z').to_a.sample)
				end
				3.times do
					temp.push([('A'..'Z').to_a.sample,('0'..'9').to_a.sample].sample)
				end
				booking = temp.join
				
				ignore = ["SELFIE","BARNEY","RACHEL","MONICA","ETIHAD","AMAZON"]
				match_check = booking.match(/\w{3}\w{3}/)
				ignore_check = !(ignore.include? booking)
				eka_check = !(booking[0,3] == "EKA")
				presence_check = !(Booking.all.pluck(:reference_num).include? booking)
				if match_check && ignore_check && eka_check && presence_check
					@booking_number = Booking.new
					@booking_number.reference_num = booking
					@booking_number.save
					flag = 1
				end
			end
			
		end
	end
end