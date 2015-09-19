#!/bin/ruby
# 531 calculator written in ruby
# Trace Norris thunderheavyindustries@gmail.com
# Feb/2015
require "open-uri"
require 'rounding'
require 'json'

class FiveThreeOne

	
	# calculates the weight needed to be added to each side of the bar
	def plate_calc weight

		weight = weight.round_to(5)
		weight_minus_bar = weight -45
		one_side=0

		while (2*one_side) < weight_minus_bar
			one_side+= 2.5
		end

		return one_side
	end


	#pulls in previous values stored in a text file
	def open_read

		contents = File.open("Lift_nums.json", "r"){ |file| file.read }
		lift_val= JSON.parse(contents)

		return lift_val
	end


	# prompts the user for the values desired to incremented by
	def update content_to_write

		puts "last round your numbers were:"
		puts content_to_write

		puts "what do you want to increment squat by?"
		content_to_write["squat"]+= (gets.chomp!).to_i

		puts "what do you want to increment Bench by?"
		content_to_write["bench"]+= (gets.chomp!).to_i

		puts "what do you want to increment Dead by?"
		content_to_write["dead"]+= (gets.chomp!).to_i

		puts "what do you want to increment Press by?"
		content_to_write["press"]+= (gets.chomp!).to_i


		somefile = File.open( "lift_nums.json", "w")
		somefile.puts content_to_write
		somefile.close 

		puts "Your values for the next cycle will be:"
		puts content_to_write
	end
	
	# this is where the majority of the work is done
	# prompts user for which lift being perfomed as well as which week the user wants to perform
	# outputs results to the terminal
	def week 


		puts "Which lift you doing brah? squat, press, dead, or bench?"
		lift = gets.chomp!
		puts  "which week brah? 1, 2, 3, or 4?"
		week_num = (gets.chomp!).to_i

		lifts_hash = open_read 
		weight = (lifts_hash[lift]*0.9)


		puts " "
		puts " You're doing week #{week_num}  #{lift} which is currently set @ #{weight.round_to(5)}lb"

		if week_num == 1
			puts "************* Week #{week_num} ***********"

			(0.45..0.85).step(0.10).each do |val|
				puts "5 reps @ #{ (weight*val).round_to(5) } with #{ plate_calc (weight*val)} on each side"
			end
			puts "***********************************"

		elsif week_num == 2
			puts " "
			puts "************* Week #{week_num} ***********"
			puts "5 reps @ #{(weight*0.5).round_to(5)} with #{plate_calc (weight*0.5)} on each side"
			puts "5 reps @ #{(weight*0.6).round_to(5)} with #{plate_calc (weight*0.6)} on each side"
			(0.7..0.9).step(.1),each do |val|
				puts "3 reps @ #{(weight*val).round_to(5)} with #{plate_calc ((weight*val))} on each side"
			end
			puts "***********************************"
			puts " "

		elsif week_num == 3
			puts " "
			puts "************* Week #{week_num} ***********"
			(0.55..0.75).step(0.1).each do |val| 
				puts "5 reps @ #{(weight*val).round_to(5)} with #{plate_calc (weight*val)} on each side"  
			end
			puts "3 reps @ #{(weight*0.85).round_to(5)} with #{plate_calc (weight*0.85)} on each side"
			puts "1 reps @ #{(weight*0.95).round_to(5)} with #{plate_calc (weight*0.95)} on each side"
			puts "***********************************"
			puts " "

		elsif week_num == 4
			puts " "
			puts "************* Week #{week_num} ***********"
			(0.2..0.6).step(0.1).each do |val|
				puts "5 reps @ #{ (weight*val).round_to(5) } with #{ plate_calc (weight*val)} on each side"
			end
			puts "***********************************"
			puts " "


			if lift=="press"
			update lifts_hash
			end

		else

			puts "Week not provided you said #{week_num}"
		end
	end
end


Five = FiveThreeOne.new
Five.week


