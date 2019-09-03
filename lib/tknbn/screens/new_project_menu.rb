# typed: false

module Tknbn
	class NewProjectMenu
		extend T::Sig
		attr_reader :win, :height, :width

		sig {void}
		def initialize
			Curses.clear
			Curses.refresh
			@height = 6
			@width = Curses.cols/2
			@win = Curses::Window.new(@height, @width, Curses.lines/3, (Curses.cols/2 - @width/2))
			display
		end

		sig {void}
		def display
			str = "Enter a name for your project"
			@win.box("|", "-")
			@win.setpos(1,1)
			@win.addstr(str)
			@win.refresh
		end

		sig {returns(Project)}
		def create_project
			@win.setpos(3,1)
			Curses.curs_set(1) # make cursor visible
			Curses.echo # display user input to screen
			input = @win.getstr
			if input.length < 1
				get_name
			else
				return Project.create(name: input)
			end
		end
	end
end
