class MainMenu
	attr_reader :win1, :win2, :win3, :width, :height
	
	def initialize(height: nil, width: nil)
		@height = height || Curses.lines
		@width = width || Curses.cols
		col_width = (@width - 2) / 3

		@win1 = Curses::Window.new(@height, col_width, 0, 0)
		@win2 = Curses::Window.new(@height, col_width, 0, (col_width + 1))
		@win3 = Curses::Window.new(@height, col_width, 0, (2 * (col_width + 1)))

		##### TODO #####
		@win1.box("|", "-")
		td = "TODO"
		@win1.setpos(1, (col_width / 2 - td.length / 2))
		@win1.addstr(td)

		curr_line = 3

		Project.first.todo.each_with_index do |i, idx|
			@win1.setpos(curr_line, 2)
			@win1.addstr("#{idx + 1}. #{i.description}")
			curr_line += 2
		end

		@win1.refresh

		#####IN PROGRESS#####
		@win2.box("|", "-")
		ip = "In Progress"
		@win2.setpos(1, (col_width / 2 - ip.length / 2))
		@win2.addstr(ip)

		curr_line = 3

		Project.first.in_progress.each_with_index do |i, idx|
			@win2.setpos(curr_line, 2)
			@win2.addstr("#{idx + 1}. #{i.description}")
			curr_line += 2
		end
		@win2.refresh

		##### DONE #####
		@win3.box("|", "-")
		d = "Done"
		@win3.setpos(1, (col_width / 2 - d.length / 2))
		@win3.addstr(d)

		curr_line = 3

		Project.first.done.each_with_index do |i, idx|
			@win3.setpos(curr_line, 2)
			@win3.addstr("#{idx + 1}. #{i.description}")
			curr_line += 2
		end
		@win3.refresh

		Curses.getch
		@win1.close
		@win2.close
		@win3.close
	end

end