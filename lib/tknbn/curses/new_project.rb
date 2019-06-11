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
		Curses.curs_set(1) # make cursor visible
		Curses.echo # make text entry visible
		input = @win.getstr # get text from user
		if input.length > 0 # if text is not empty
			p = Project.create(name: input)
		else
			p = nil
		end
		Curses.curs_set(0)
		Curses.noecho
		p # return new project or nil
	end
end