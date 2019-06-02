class MainMenu
	attr_reader :win1, :win2, :win3, :width, :height
	
	def initialize(height: nil, width: nil)
		@height = height || Curses.lines
		@width = width || Curses.cols
		col_width = (@width - 2) / 3

		@win1 = Curses::Window.new(@height, col_width, 0, 0)
		@win2 = Curses::Window.new(@height, col_width, 0, (col_width + 1))
		@win3 = Curses::Window.new(@height, col_width, 0, (2 * (col_width + 1)))

		@win1.box("|", "-")
		td = "TODO"
		@win1.setpos(1, (col_width / 2 - td.length / 2))
		@win1.addstr(td)
		@win1.refresh

		@win2.box("|", "-")
		ip = "In Progress"
		@win2.setpos(1, (col_width / 2 - ip.length / 2))
		@win2.addstr(ip)
		@win2.refresh

		@win3.box("|", "-")
		d = "Done"
		@win3.setpos(1, (col_width / 2 - d.length / 2))
		@win3.addstr(d)
		@win3.refresh

		Curses.getch
		@win1.close
		@win2.close
		@win3.close
	end

end