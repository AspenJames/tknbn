require "tknbn/version"
require 'pry'
require 'curses'

module Tknbn
  class Error < StandardError; end
	# Your code goes here...
	
	class App
		attr_reader :win, :width, :height

		def initialize
			@win = Curses.init_screen
			@width = Curses.cols
			@height = Curses.lines
			@win.keypad = true
			Curses.noecho
			Curses.cbreak
			Curses.crmode
			Curses.curs_set(0)
			self.run
		end

		def run
			str = '' # init a string variable
			loop do
				@win.clear
				menu_string = "Welcome to TKNBN\n"
				Curses.setpos(@height/2, @width/2 - menu_string.length/2)
				Curses.addstr(menu_string)
				Curses.setpos(@height/2 + 1, @width/2 - str.length/2)
				Curses.addstr(str)
				@win.refresh

				input = @win.getch # get keypress from user
				case input
				when "d"
					MainMenu.new()
				when "m"
					choice = ProjectMenu.new().get_choice
					if choice == Project.all.length
						# Create a new project
						@win.clear
						@win.refresh
						p = NewProject.new.get_name
						@win.clear
						@win.refresh
						MainMenu.new(project: p)
					else
						proj = Project.all[choice]
						@win.clear
						@win.refresh
						MainMenu.new(project: proj)
					end
				when "q"
					break # exit the loop when we're done
				else
					# This is good for getting character keys and/or
					# codes as read by Curses.getch
					str = "#{input} key pressed"
					Curses.setpos(@height/2 + 1, 0)
					Curses.addstr(str)
				end
			end
			Curses.close_screen # close the screen when we're done
		end
	end
end
