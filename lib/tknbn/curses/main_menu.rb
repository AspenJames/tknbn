class MainMenu
	attr_reader :win1, :win2, :win3, :width, :height, :col_width, :project, :hl
	
	def initialize(height: nil, width: nil, project: nil)
		# Can be initialized with a height, width, and project
		# Height and width default to all available window space,
		# project defaults to the last project created
		@height = height || Curses.lines
		@width = width || Curses.cols
		@project = project || Project.last
		@col_width = (@width - 2) / 3	# This sets up the width of each column

		@win1 = Curses::Window.new(@height, @col_width, 0, 0)
		@win2 = Curses::Window.new(@height, @col_width, 0, (@col_width + 1))
		@win3 = Curses::Window.new(@height, @col_width, 0, (2 * (@col_width + 1)))

		# Create a Highlight struct to maintain a 'pointer'
		# to the currently selected item
		@hl = Struct.new(:col, :itm).new(1, 1)

		scroll_loop

		Curses.getch
		@win1.close
		@win2.close
		@win3.close
	end

	def scroll_loop
		loop do
			display_items
			c = Curses.getch
			case c
			when 'j'
				move_cursor_down
			when 'k'
				move_cursor_up
			when 'h'
				move_cursor_left
			when 'l'
				move_cursor_right
			when 'q'
				break
			end
		end
	end

	def move_cursor_left
		if @hl.col == 1 # If leftmost selected
			@hl.col = 3		# Move to rightmost
			num_items = get_num_items
			if @hl.itm > num_items
				@hl.itm = num_items
			end
		elsif @hl.col == 3 # If rightmost selected
			@hl.col = 2			 # Move to middle
			num_items = get_num_items
			if @hl.itm > num_items
				@hl.itm = num_items
			end
		else
			@hl.col = 1 # Move leftmost
			num_items = get_num_items
			if @hl.itm > num_items
				@hl.itm = num_items
			end
		end
	end

	def move_cursor_right
		if @hl.col == 3 # If rightmost selected
			@hl.col = 1		# Move to leftmost
			num_items = get_num_items
			if @hl.itm > num_items
				@hl.itm = num_items
			end
		elsif @hl.col == 1 # If leftmost selected
			@hl.col = 2			 # Move to middle
			num_items = get_num_items
			if @hl.itm > num_items
				@hl.itm = num_items
			end
		else
			@hl.col = 3 # Move rightmost
			num_items = get_num_items
			if @hl.itm > num_items
				@hl.itm = num_items
			end
		end
	end

	def move_cursor_down
		num_items = get_num_items
		# Update the item pointer
		if @hl.itm >= num_items
			@hl.itm = 1
		else
			@hl.itm += 1
		end
	end

	def move_cursor_up
		num_items = get_num_items
		# Update item pointer
		if @hl.itm == 1
			@hl.itm = num_items
		else
			@hl.itm -= 1
		end
	end

	def get_num_items
		# Determine number of items in list
		if @hl.col == 1
			num_items = @project.todo.count
		elsif @hl.col == 2
			num_items = @project.in_progress.count
		elsif @hl.col == 3
			num_items = @project.done.count
		end
		num_items
	end

	def display_items
		##### TODO #####
		@win1.box("|", "-")
		# sub-window for the text area, so we can avoid overlapping the
		# window border box we drew directly above.
		w1_text_area = @win1.derwin(@height - 2, @col_width - 4, 1, 2)
		td = "TODO"
		# add the title text to the main column window for placement reasons
		@win1.setpos(1, (@col_width / 2 - td.length / 2))
		@win1.attrset(Curses::A_STANDOUT | Curses::A_UNDERLINE)
		@win1.addstr(td)
		@win1.attroff(Curses::A_STANDOUT | Curses::A_UNDERLINE)

		curr_line = 3

		@project.todo.each_with_index do |i, idx|
			w1_text_area.setpos(curr_line, 0)
			str = "#{idx + 1}. #{i.description}"
			if @hl.col == 1 && @hl.itm == idx + 1 # implement highlight
				w1_text_area.attrset(Curses::A_REVERSE)
				w1_text_area.addstr(str)
				w1_text_area.attroff(Curses::A_REVERSE)
			else
				w1_text_area.addstr(str)
			end
			# This next line handles spacing elements that wrap
			# beyond a single line.
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
			if @hl.col == 2 && hl.itm == idx + 1
				w2_text_area.attrset(Curses::A_REVERSE)
				w2_text_area.addstr(str)
				w2_text_area.attroff(Curses::A_REVERSE)
			else
				w2_text_area.addstr(str)
			end
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
			if @hl.col == 3 && @hl.itm == idx + 1
				w3_text_area.attrset(Curses::A_REVERSE)
				w3_text_area.addstr(str)
				w3_text_area.attroff(Curses::A_REVERSE)
			else
				w3_text_area.addstr(str)
			end
			curr_line += (str.length / (@col_width - 4) + 2)
		end
		@win3.refresh
	end

end
