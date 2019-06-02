class ProjectMenu
	attr_accessor :win, :height, :width

	def initialize(height: nil, width: nil)
		@height = height || Curses.lines / 2
		@width = width || Curses.cols / 2
		cur_line = 2

		@win = Curses::Window.new(@height, @width, @height/2, @width/2)
		@win.box("/","~")
		@win.setpos(cur_line, 2)
		cur_line += 1
		cur_line += 1
		@win.addstr("Choose an option")

		Project.all.each do |p|
			@win.setpos(cur_line, 3)
			@win.addstr(p.display)
			cur_line += 1
		end
		@win.refresh
		@win.getch
		@win.close
	end
end