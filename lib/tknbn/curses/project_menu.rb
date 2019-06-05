class ProjectMenu
	attr_accessor :win, :height, :width, :highlight

	def initialize(height: nil, width: nil)
		@height = height || Curses.lines / 2
		@width = width || Curses.cols / 2
		@win = Curses::Window.new(@height, @width, @height/2, @width/2)

		@highlight = 1
	end

	def get_choice
		begin
			@win.box("/","~")
			@win.setpos(2, 2)
			@win.addstr("Choose an option")

			loop do
				display_menu
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
			end
		ensure
			@win.close
		end
		@choice - 1
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
