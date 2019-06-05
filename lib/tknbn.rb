require "tknbn/version"
require 'pry'
require 'curses'

module Tknbn
  class Error < StandardError; end
	# Your code goes here...
	
	class App
		attr_reader :win, :width, :height
		@@is_running = true

		def initialize
			@win = Curses.init_screen
			@width = Curses.cols
			@height = Curses.lines
			@win.keypad = true
			Curses.noecho
			Curses.cbreak
			Curses.curs_set(0)
			self.run
		end

		def run
			input = nil
			str = ''
			while @@is_running
				@win.clear
				menu_string = "Welcome to TKNBN\n"
				Curses.setpos(@height/2, @width/2 - menu_string.length/2)
				Curses.addstr(menu_string)
				Curses.setpos(@height/2 + 1, @width/2 - str.length/2)
				Curses.addstr(str)
				@win.refresh
				input = @win.getch
				case input
				when "d"
					MainMenu.new()
				when "q"
					break
				when "m"
					choice = ProjectMenu.new().get_choice
					proj = Project.all[choice]
					@win.clear
					@win.refresh
					MainMenu.new(project: proj)
				else
					str = "#{input} key pressed"
					Curses.setpos(@height/2 + 1, 0)
					Curses.addstr(str)
					# @win.refresh
					# @win.getch
					# @@is_running = false
				end
			end
			Curses.close_screen
		end
	end
end
