class MainMenu
	attr_reader :win1, :win2, :win3, :width, :height, :col_width, :project
	
	def initialize(height: nil, width: nil, project: nil)
		@height = height || Curses.lines
		@width = width || Curses.cols
		@project = project || Project.last
		@col_width = (@width - 2) / 3

		@win1 = Curses::Window.new(@height, @col_width, 0, 0)
		@win2 = Curses::Window.new(@height, @col_width, 0, (@col_width + 1))
		@win3 = Curses::Window.new(@height, @col_width, 0, (2 * (@col_width + 1)))

		##### TODO #####
		@win1.box("|", "-")
		w1_text_area = @win1.derwin(@height - 2, @col_width - 4, 1, 2)
		td = "TODO"
		@win1.setpos(1, (@col_width / 2 - td.length / 2))
		@win1.attrset(Curses::A_STANDOUT | Curses::A_UNDERLINE)
		@win1.addstr(td)
		@win1.attroff(Curses::A_STANDOUT | Curses::A_UNDERLINE)

		curr_line = 3

		@project.todo.each_with_index do |i, idx|
			w1_text_area.setpos(curr_line, 0)
			str = "#{idx + 1}. #{i.description}"
			w1_text_area.addstr(str)
			curr_line += (str.length / (@col_width - 4) + 2)
		end

		@win1.refresh

		#####IN PROGRESS#####
		@win2.box("|", "-")
		w2_text_area = @win2.derwin(@height - 2, @col_width - 4, 1, 2)
		ip = "In Progress"
		@win2.setpos(1, (@col_width / 2 - ip.length / 2))
		@win2.attrset(Curses::A_STANDOUT | Curses::A_UNDERLINE)
		@win2.addstr(ip)
		@win2.attroff(Curses::A_STANDOUT | Curses::A_UNDERLINE)

		curr_line = 3

		@project.in_progress.each_with_index do |i, idx|
			w2_text_area.setpos(curr_line, 0)
			str = "#{idx + 1}. #{i.description}"
			w2_text_area.addstr(str)
			curr_line += (str.length / (@col_width - 4) + 2)
		end
		@win2.refresh

		##### DONE #####
		@win3.box("|", "-")
		w3_text_area = @win3.derwin(@height - 2, @col_width - 4, 1, 2)
		d = "Done"
		@win3.setpos(1, (@col_width / 2 - d.length / 2))
		@win3.attrset(Curses::A_STANDOUT | Curses::A_UNDERLINE)
		@win3.addstr(d)
		@win3.attroff(Curses::A_STANDOUT | Curses::A_UNDERLINE)

		curr_line = 3

		@project.done.each_with_index do |i, idx|
			w3_text_area.setpos(curr_line, 0)
			str = "#{idx + 1}. #{i.description}"
			w3_text_area.addstr(str)
			curr_line += (str.length / (@col_width - 4) + 2)
		end
		@win3.refresh

		Curses.getch
		@win1.close
		@win2.close
		@win3.close
	end

end
