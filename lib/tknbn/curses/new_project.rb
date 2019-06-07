class NewProject
	attr_accessor :win, :height, :width

	def initialize(height: nil, width: nil)
		@height = height || 6
		@width = width || Curses.cols / 2
		@win = Curses::Window.new(@height, @width, Curses.lines / 3, (Curses.cols / 2 - @width / 2))
	end

	def display
		str = "Enter a name for your project\n"
		@win.setpos(1,1)
		@win.addstr(str)
		@win.refresh
	end

	def get_name
		display
		@win.setpos(3,1)
		Curses.curs_set(1)
		Curses.echo
		input = @win.getstr
		if input.length > 1
			p = Project.create(name: input)
		else
			@win.clear
			get_name
		end
		Curses.curs_set(0)
		Curses.noecho
		p
	end
end