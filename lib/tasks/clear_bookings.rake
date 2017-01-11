task :clear_bookings => :environment do 
	Booking.delete_all
end