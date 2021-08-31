puts 'SEEDING STARTED'

puts 'Hotels'
Seeds::FillHotels.perform_for [{ name: 'Clarion Hotel The Hub', city: 'Oslo', number_of_rooms: 20, price: 25.9 },
                               { name: 'Citybox Oslo', city: 'Oslo', number_of_rooms: 10, price: 20.9 },
                               { name: 'Comfort Hotel Bergen', city: 'Bergen', number_of_rooms: 15, price: 25.9 },
                               { name: 'Radisson Blu Royal Hotel', city: 'Bergen', number_of_rooms: 25, price: 15.9 },
                               { name: 'Scandic Ishavshotel', city: 'Tromso', number_of_rooms: 35, price: 80.5 },
                               { name: 'Clarion Hotel The Edge', city: 'Tromso', number_of_rooms: 5, price: 9 }]
