class ProjectMenu
	attr_accessor :win, :height, :width, :highlight

	def initialize(height: nil, width: nil)
		@height = height || Curses.lines / 2
		@width = width || Curses.cols / 2
		cur_line = 2

		@highlight = 1

		@win = Curses::Window.new(@height, @width, @height/2, @width/2)
		@win.box("/","~")
		@win.setpos(cur_line, 2)
		cur_line += 1
		cur_line += 1
		@win.addstr("Choose an option")

		loop do
			c = @win.getch
			case c
			when 'j'
				if @highlight == Project.all.length
					@highlight = 1
				else
					@highlight += 1
				end
			when 'k'
				if @highlight == 1
					@highlight = Project.all.length
				else
					@highlight -= 1
				end
			when 10
				@choice = @highlight
				break
			end
			display_menu
		end

		# Project.all.each do |p|
		# 	@win.setpos(cur_line, 3)
		# 	@win.addstr(p.display)
		# 	cur_line += 1
		# end
		@win.refresh
		@win.getch
		@win.close
	end

	def display_menu
		cur_line = 4
		n_choices = Project.all.length
		Project.all.each_with_index do |p, idx|
			@win.setpos(cur_line, 3)

			if @highlight == idx + 1
				@win.attron(Curses::A_REVERSE)
				@win.addstr(p.name)
				@win.attroff(Curses::A_REVERSE)
			else
				@win.addstr(p.name)
			end
			cur_line += 1
		end
		@win.refresh
	end
end
