# typed: false
require "tknbn/version"
require 'Curses'

module Tknbn
  class Error < StandardError; end

	class App
		attr_reader :win, :width, :height

		sig {void}
		def initialize
			@win = Curses.init_screen
			@width = Curses.cols
			@height = Curses.lines

			@win.keypad = true
			Curses.start_color
			Curses.noecho
			Curses.cbreak
			Curses.crmode
			Curses.curs_set(0)
			Curses.init_pair(1, Curses::COLOR_RED, Curses::COLOR_BLACK)
			Curses.init_pair(2, Curses::COLOR_CYAN, Curses::COLOR_BLACK)

			run
		end

		sig {void}
		def run
			display_welcome_screen
			sleep(2)
			choice = ProjectChoiceMenu.new
			if choice == Project.all.length
				create_new_project
			else
				get_selected_project
			end
			Curses.close_screen
		end

		sig {void}
		def display_welcome_screen
			@win.clear
			welcome = "Welcome to TKNBN"
			screen_notice = "[best viewed in full screen]"

			Curses.setpos(@height/2, @width/2 - welcome.length/2)
			Curses.addstr(welcome)
			Curses.setpos(@height/2 + 1, @width/2 - screen_notice.length/2)
			Curses.addstr(screen_notice)
			@win.refresh
		end

		sig {void}
		def create_new_project
			p = NewProjectMenu.new
			@win.clear
			@win.refresh
			ProjectDisplay.new(project: p)
		end

		sig {params(choice: Integer).void}
		def get_selected_project(choice)
			proj = Project.most_recently_updated[choice]
			@win.clear
			@win.refresh
			ProjectDisplay.new(project: p)
		end
	end
end
